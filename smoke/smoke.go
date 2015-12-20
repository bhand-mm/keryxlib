package main

// Copyright 2015 MediaMath <http://www.mediamath.com>.  All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"

	keryxlib "github.com/MediaMath/keryxlib"
	"github.com/MediaMath/keryxlib/message"
	"github.com/MediaMath/keryxlib/tko"
	"github.com/codegangsta/cli"
)

var (
	configFlag = cli.StringFlag{
		Name:   "config",
		Usage:  "Path to the kerxyp config file",
		EnvVar: "SMOKE_CONFIG",
	}

	timeoutFlag = cli.IntFlag{
		Name:   "timeout",
		Usage:  "How long to look for the condition in seconds.",
		Value:  60,
		EnvVar: "SMOKE_TIMEOUT",
	}
)

func main() {
	app := cli.NewApp()
	app.Name = "smoke"
	app.Usage = "run tko conditions directly on a database"
	app.Flags = []cli.Flag{configFlag}

	app.Action = func(ctx *cli.Context) {
		configFile := configFileRequired(ctx)
		config, err := keryxlib.ConfigFromFile(configFile)
		if err != nil {
			log.Fatalf("Load %s failed: %v", configFile, err)
		}

		condition, err := tko.GetConditionFromArgsOrStdIn(ctx)
		if err != nil {
			log.Fatalf("Condition error: %v", err)
		}

		timeout := ctx.Int("timeout")
		if timeout < 1 {
			log.Fatalf("Timeout must be > 0")
		}

		txn, err := runSmoke(config, condition, time.Duration(timeout)*time.Second)

		if err != nil {
			log.Fatal(err)
		}

		if txn != nil {
			j, err := json.Marshal(txn)
			if err != nil {
				log.Fatal(err)
			}

			fmt.Println(string(j))
		}

		log.Fatal("Nothing found in specified time.")
	}

	app.Run(os.Args)
}

func configFileRequired(ctx *cli.Context) string {
	configFile := ctx.String(configFlag.Name)

	if configFile == "" {
		log.Fatalf("No %s specified.", configFlag.Name)
	}

	return configFile
}

func runSmoke(config *keryxlib.Config, condition tko.Condition, timeout time.Duration) (*message.Transaction, error) {

	keryxChan, err := keryxlib.TransactionChannel("smoke", config)
	if err != nil {
		return nil, err
	}

	endAfter := time.After(timeout)

	for {
		select {
		case <-endAfter:
			return nil, nil
		case txn, more := <-keryxChan:
			if more {
				if condition.Check(txn) {
					return txn, nil
				}
			} else {
				return nil, nil
			}
		}
	}
}

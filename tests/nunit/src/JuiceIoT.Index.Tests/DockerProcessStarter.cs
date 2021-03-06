﻿using System;
using System.IO;

namespace JuiceIoT.Index.Tests
{
	public class DockerProcessStarter
	{
		public ProcessStarter Starter = new ProcessStarter();

		public string WorkingDirectory = Directory.GetCurrentDirectory();

		public string PreCommand = "";

		public string ExtraDockerArguments = "";

		public bool IsMockDocker = false;

		public DockerProcessStarter()
		{
		}

		protected string RunProcess(string command)
		{
			var currentDirectory = Environment.CurrentDirectory;

			Directory.SetCurrentDirectory(WorkingDirectory);

			Console.WriteLine("Running docker process...");
			Console.WriteLine(command);

			Starter.Start(command);
			var output = Starter.Output;

			Directory.SetCurrentDirectory(currentDirectory);

			return output;
		}

		protected string RunDockerProcess(string command)
		{
			var fullCommand = "";
			if (!IsMockDocker)
			{
				fullCommand += "docker run -i --rm ";
				fullCommand += ExtraDockerArguments;
				fullCommand += " -v " + WorkingDirectory + ":~/workspace/JuiceIoT/Index -v /var/run/docker.sock:/var/run/docker.sock compulsivecoder/ubuntu-arm-iot-mono";
			}
			fullCommand += " " + command;

			return RunProcess(fullCommand.Trim());
		}

		public string RunDockerBash(string internalCommand)
		{
			var fullPreCommand = "";
			if (!String.IsNullOrEmpty(PreCommand))
				fullPreCommand = PreCommand + " && ";

			var cdCommand = "cd ~/workspace/JuiceIoT/Index &&";

			// If docker is mocked don't change the directory
			if (IsMockDocker)
				cdCommand = "";

			var fullCommand = "/bin/bash -c \"" + cdCommand + " " + fullPreCommand + internalCommand + "\"";

			return RunDockerProcess(fullCommand);
		}

		public string RunScript(string scriptName)
		{
			if (!scriptName.EndsWith(".sh"))
				scriptName += ".sh";

			var fullCommand = "sh " + scriptName;

			return RunDockerBash(fullCommand);
		}

	}
}

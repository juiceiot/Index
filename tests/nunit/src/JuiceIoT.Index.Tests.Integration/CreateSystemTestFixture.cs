
using System;
using NUnit.Framework;
using System.IO;

namespace JuiceIoT.Index.Tests.Integration
{
	[TestFixture(Category = "Integration")]
	public class CreateSystemTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateScript()
		{
			var scriptName = "create-system";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			Console.WriteLine("Running create-system script");

			var starter = GetDockerProcessStarter();
			starter.PreCommand = "sh init-mock-setup.sh && sh clean.sh";
			var output = starter.RunScript(scriptName);

			var successfulText = "Setup complete";

			Assert.IsTrue(output.Contains(successfulText), "Failed");

			var serviceFileName = "juiceiot-mosquitto-docker.service";

			CheckServiceExists(serviceFileName);
		}

		public void CheckServiceExists(string serviceFileName)
		{
			if (!serviceFileName.EndsWith(".service"))
				serviceFileName += ".service";

			var serviceFilePath = Path.Combine(TemporaryServicesDirectory, serviceFileName);

			Console.WriteLine("Checking mosquitto service file exists...");
			Console.WriteLine("  " + serviceFilePath);

			var serviceFileExists = File.Exists(serviceFilePath);

			Assert.IsTrue(serviceFileExists, "Service file not found.");
		}
	}
}

using System;
using NUnit.Framework;

namespace JuiceIoT.Index.Tests.Integration
{
	[TestFixture(Category = "Integration")]
	public class CreateProtectorNanoTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateProtectorNanoScript()
		{
			var scriptName = "create-protector-nano.sh";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			var deviceType = "protector/VoltageCurrentMAX471SensorCalibratedSwitch";
			var deviceLabel = "MyProtector";
			var deviceName = "myProtector";
			var devicePort = "ttyUSB1";

			var arguments = deviceLabel + " " + deviceName + " " + devicePort;

			var starter = GetDockerProcessStarter();
			starter.PreCommand = "sh init-mock-setup.sh && sh clean.sh";
			starter.RunDockerBash("sh " + scriptName + " " + arguments);

			CheckDeviceInfoWasCreated(deviceType, deviceLabel, deviceName, devicePort);

			CheckDeviceUIWasCreated(deviceLabel, deviceName, "Meter1", "A", "Voltage", "VC");

			CheckMqttBridgeServiceFileWasCreated(deviceName);

			CheckUpdaterServiceFileWasCreated(deviceName);
		}
	}
}

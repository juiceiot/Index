using System;
using NUnit.Framework;
namespace JuiceIoT.Index.Tests.Integration
{
	[TestFixture(Category = "Integration")]
	public class CreateMeterNanoTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateMeterNanoScript()
		{
			var scriptName = "create-meter-nano.sh";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			var deviceType = "meter/VoltageCurrentMAX471SensorCalibratedSerial";
			var deviceLabel = "MyMeter1";
			var deviceName = "myMeter1";
			var devicePort = "ttyUSB0";

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

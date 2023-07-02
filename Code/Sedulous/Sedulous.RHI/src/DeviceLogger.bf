using System;
namespace Sedulous.RHI;

class DeviceLogger
{
	private readonly GraphicsAPI m_GraphicsAPI;
	private readonly CallbackInterface m_CallbackInterface;

	public this(GraphicsAPI graphicsAPI, CallbackInterface callbackInterface)
	{
		m_GraphicsAPI = graphicsAPI;
		m_CallbackInterface = callbackInterface;
	}

	public void ReportMessage(Message message, StringView format, params Object[] args)
	{
		readonly char8* messageTypeName = MESSAGE_TYPE_NAME[(uint)message];
		readonly char8* graphicsAPIName = GRAPHICS_API_NAME[(uint)m_GraphicsAPI];

		var formattedMessage = scope String();
		formattedMessage.AppendF(scope $"RHI({0})::{1} -- {format}", graphicsAPIName, messageTypeName, args);

		if (m_CallbackInterface.MessageCallback != null)
			m_CallbackInterface.MessageCallback(m_CallbackInterface.userArg, formattedMessage, message);

		if (message == Message.TYPE_ERROR && m_CallbackInterface.AbortExecution != null)
			m_CallbackInterface.AbortExecution(m_CallbackInterface.userArg);
	}
}
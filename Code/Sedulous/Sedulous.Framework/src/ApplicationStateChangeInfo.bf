namespace Sedulous.Framework;

struct ApplicationStateChangeInfo
{
	public Application Application;
	public ApplicationState PreviousState;
	public ApplicationState CurrentState;
}
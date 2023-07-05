namespace Sphenery.Framework;

abstract class Plugin
{
	public virtual void Initialize(Application application){}
	public virtual void Shutdown(Application application){}
}
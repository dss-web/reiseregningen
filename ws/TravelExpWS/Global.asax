<%@ Application Language="C#" %>

<script runat="server">

    //log4net
    private static log4net.ILog log = log4net.LogManager.GetLogger("Global");

    
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        log4net.Config.XmlConfigurator.Configure();
        log.Info("Application_Start: Starting application");
        CreateStoredPdfIdRepository();

    }

    private void CreateStoredPdfIdRepository()
    {
        if (Application["StoredPdfIdRepository"] == null)
        {
            MakingWaves.TravelExp.Impl.TravelExpense.Processing.StoredDataRepository.CreateInstance();
            Application["StoredPdfIdRepository"] = MakingWaves.TravelExp.Impl.TravelExpense.Processing.StoredDataRepository.Instance;
        }
        else
        {
            log.Warn("StoredPdfIdRepository (in Application dictionary) already exists... - strange");
            // call 'instance' to see if there is really an instance of it.
            log.Info("StoredPdfIdRepostiory content is \n" + MakingWaves.TravelExp.Impl.TravelExpense.Processing.StoredDataRepository.Instance.ToString());
        }
    }
   
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown
        log.Info("Application_End - ending application...");

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>

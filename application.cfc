component output="true"{
    this.name = "catholicity";
    this.sessionManagement = true;
    this.sessionTimeout = CreateTimeSpan(0,0,10,0);
    this.clientManagement = true;
    this.clientStorage = "cookie";
    
    function onApplicationStart(){
        return true;
    }
    
    function onError( required exception, required eventName ){
        writeDump( var = arguments.exception, abort = true );
    }
}
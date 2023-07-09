public class ip {
    public String ipstring { get; set; }

    public String getIpstring() {
        return null;
    }
    public ip(){
    ipstring= ApexPages.currentPage().getHeaders().get('x-Salesforce-SIP');
    }

}
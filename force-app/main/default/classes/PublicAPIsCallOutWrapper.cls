public with sharing class PublicAPIsCallOutWrapper {
  public PublicAPIsCallOutWrapper() {
  }

  public Integer count;
  public List<Entries> entries;

  public class Entries {
    public String API;
    public String Description;
    public String Category;
    public String Link;
  }
}
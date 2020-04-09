package enums
public enum Visibility {
    PUBLIC("PUBLIC"),
    PRIVATE("PRIVATE")
    final String value
    Visibility(String value){
        this.value = value;
    }
    String toString() {
        value
    }
    String getKey() {
        name()
    }
    static list(){
        [PUBLIC,PRIVATE]
    }
}

package enums
enum Seriousness {
    CASUAL("CASUAL"),
    SERIOUS("SERIOUS"),
    VERYSERIOUS("VERY SERIOUS")
    final String value
    Seriousness(String value){
        this.value = value;
    }
    String toString() {
        value
    }
    String getKey() {
        name()
    }
    static list(){
        [CASUAL,SERIOUS,VERYSERIOUS]
    }
}
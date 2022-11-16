class Person {

  /* fields */ 
  private String name;	
  private String address;
  private Int phone;

  Phone(String name, String address, Int phone){
      this.name = name
      this.address = address
      this.phone = phone
  }
}


class Company {

  /* fields */ 
  private String name;	
  private String address;

  Entry(String name, String address){
      this.name = name
      this.address = address
      this.createPerson("jp", "amsterdam", "0602938475")
  }

    public createPerson(String name, String address, String phone){
        if(name != ""){
            Person(name, address, phone)
        }
    }

}


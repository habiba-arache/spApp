## ⚙️ Database Configuration (Hibernate)

Before running the project, you must configure your MySQL connection settings in the file:

   src/main/resources/hibernate.cfg.xml

---

## 📄 Default Configuration File

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
        "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
    <session-factory>
        <property name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
        <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/sportProgressDb</property>
        <property name="hibernate.connection.username">root</property>
        <property name="hibernate.connection.password">password</property>
        <property name="hibernate.dialect">org.hibernate.dialect.MySQL8Dialect</property>

        <property name="hibernate.format_sql">true</property>
        <property name="hibernate.show_sql">true</property>

        <property name="hibernate.hbm2ddl.auto">update</property>

        <mapping class="com.model.User"/>
        <mapping class="com.model.WorkOut"/>
        <mapping class="com.model.WeightRecord"/>
        <mapping class="com.model.Diet"/>
    </session-factory>
</hibernate-configuration>
```
🔧 Required Changes Before Running the Project

👉 You must update the following fields to match your local MySQL configuration:

1️⃣ Database Name:

***Set the name of the database you created:

```<property name="hibernate.connection.url">jdbc:mysql://localhost:3306/YOUR_DATABASE_NAME</property>```

2️⃣ MySQL Username:

***Replace with your MySQL username:

```<property name="hibernate.connection.username">YOUR_USERNAME</property>```

3️⃣ MySQL Password:

***Replace with your MySQL password:

```<property name="hibernate.connection.password">YOUR_PASSWORD</property>```


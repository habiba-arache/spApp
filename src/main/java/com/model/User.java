package com.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullName;
    private String email;
    private String gender;
    protected String password;
    private float weight;
    private float height;
    private float goalWeight;
    private int age;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Task> tasks;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<RecommandedFood> foods;

    public User() {}

    public User(String fullName, String email, String password, float weight, float height, float goalWeight, int age, String gender) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.weight = weight;
        this.height = height;
        this.goalWeight = goalWeight;
        this.age = age;
        this.gender = gender;
        this.foods = new ArrayList<>();
        this.tasks = new ArrayList<>();
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String name) { this.fullName = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public float getWeight() { return weight; }
    public void setWeight(float weight) { this.weight = weight; }

    public float getHeight() { return height; }
    public void setHeight(float height) { this.height = height; }

    public float getGoalWeight() { return goalWeight; }
    public void setGoalWeight(float goalWeight) { this.goalWeight = goalWeight; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public List<Task> getTasks() { return tasks; }
    public void setTasks(List<Task> tasks) { this.tasks = tasks; }

    public List<RecommandedFood> getRecommandedFoods() { return foods; }
    public void setRecommandedFoods(List<RecommandedFood> recommandedFoods) { this.foods = recommandedFoods; }
}

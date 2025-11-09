package com.model;

import jakarta.persistence.*;

@Entity
@Table(name = "diet")
public class Diet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String foodName;
    private String type;
    private String foodDescription;
 private Float calories;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Diet() {}

    public Diet(String foodName, String foodDescription, String type,User user, float calories) {
        this.calories=calories;
        this.foodName = foodName;
        this.type=type;
        this.foodDescription = foodDescription;
        this.user = user;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String t) { this.foodName = foodName; }

    public String getType() { return type; }
    public void setType(String t) { this.type = t; }

    public String getFoodDescription() { return foodDescription; }
    public void setFoodDescription(String foodDescription) { this.foodDescription = foodDescription; }

    public Float getCalories() { return calories; }
    public void setCalories(Float cal) { this.calories = cal; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}

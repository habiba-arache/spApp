package com.model;

import jakarta.persistence.*;

@Entity
@Table(name = "foods")
public class RecommandedFood {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String foodName;
    private String foodDescription;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public RecommandedFood() {}

    public RecommandedFood(String foodName, String foodDescription, User user) {
        this.foodName = foodName;
        this.foodDescription = foodDescription;
        this.user = user;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getFoodDescription() { return foodDescription; }
    public void setFoodDescription(String foodDescription) { this.foodDescription = foodDescription; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}

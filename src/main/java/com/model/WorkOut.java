package com.model;

import jakarta.persistence.*;

@Entity
@Table(name = "workout")
public class WorkOut {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private boolean isComplete;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public WorkOut() {
    }

    public WorkOut(String name, String description, User user) {
        this.name = name;
        this.description = description;
        this.user = user;
        this.isComplete = false;
    }

    //getters & setters
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(boolean status) {
        this.isComplete = status;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public Long getId() {
        return id;
    }

    public boolean isComplete() {
        return isComplete;
    }
}

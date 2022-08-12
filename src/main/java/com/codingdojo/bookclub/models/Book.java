package com.codingdojo.bookclub.models;

import com.sun.istack.NotNull;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Entity
@Table(name="books")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Title must not be blank")
    private String title;


    @NotBlank(message = "Description must not be blank")
    @Size(min = 5,message = "Description must be at least 5 characters long")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User creator;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "users_favorite_books",
            joinColumns = @JoinColumn(name = "book_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    List<User> users;



    @Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;

    public Book() {
    }

    public Book(Long id, String title, String description, User creator, List<User> users, Date createdAt, Date updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.creator = creator;
        this.users = users;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
     @PrePersist
     protected  void onCreate(){
        this.createdAt = new Date();
     }

     @PreUpdate
     protected  void onUpdate(){
        this.updatedAt = new Date();
     }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }


    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }


    public String getCreatedAtFormated(){
        String pattern = "MMM dd , yyyy @ HH:mm";
        SimpleDateFormat simpleDateFormat =new SimpleDateFormat(pattern);
        return simpleDateFormat.format(createdAt);
    }
   public String getUpdatedAtFormated(){
        if(updatedAt == null)
            return "--";
        String pattern = "MMM dd , yyyy @ HH:mm";
        SimpleDateFormat simpleDateFormat =new SimpleDateFormat(pattern);
        return simpleDateFormat.format(updatedAt);
    }


}
package com.codingdojo.bookclub.repositories;

import com.codingdojo.bookclub.models.Book;
import com.codingdojo.bookclub.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByUsername(String username);
    User findByEmail(String email);

    List<User> findAll();

    List<User> findAllByfavoriteBooks(Book book);

}
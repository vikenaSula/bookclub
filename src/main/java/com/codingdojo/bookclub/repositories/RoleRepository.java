package com.codingdojo.bookclub.repositories;

import com.codingdojo.bookclub.models.Role;
import com.codingdojo.bookclub.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {

    List<Role> findAll();
    List<Role> findByName(String name);
}
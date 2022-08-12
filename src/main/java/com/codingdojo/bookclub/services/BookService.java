package com.codingdojo.bookclub.services;


import com.codingdojo.bookclub.models.Book;
import com.codingdojo.bookclub.models.User;
import com.codingdojo.bookclub.repositories.BookRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {
    private final BookRepository bookRepository;

    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> allBooks() {
        return bookRepository.findAll();
    }

    public Book createBook(Book book) {
        return bookRepository.save(book);
    }

    public Book findBook(Long id) {
        return bookRepository.findById(id).orElse(null);
    }

    public void deleteBook(Long id){
        bookRepository.deleteById(id);
    }

    public Book update(Book book, Book oldBook){
        List<User> userList =oldBook.getUsers();
        book.setUsers(userList);

        return bookRepository.save(book);
    }


    public void addToFavorites(Book book, User user){
        book.getUsers().add(user);
        bookRepository.save(book);
    }

    public void removeFromFavorite(Book book, User user){
        book.getUsers().remove(user);
        bookRepository.save(book);
    }


}

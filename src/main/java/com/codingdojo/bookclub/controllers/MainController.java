package com.codingdojo.bookclub.controllers;

import com.codingdojo.bookclub.models.Book;
import com.codingdojo.bookclub.models.User;
import com.codingdojo.bookclub.services.BookService;
import com.codingdojo.bookclub.services.UserService;
import com.codingdojo.bookclub.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    UserService userService;

    @Autowired
    UserValidator userValidator;

    @Autowired
    BookService bookService;

    @RequestMapping("/register")
    public String registration(
            @Valid @ModelAttribute("user") User user,
            BindingResult result,
            Model model,
            HttpSession session,
            HttpServletRequest request) {
        userValidator.validate(user, result);
        String password = user.getPassword();
        if(result.hasErrors()) {
            return "index.jsp";
        }

            userService.newUser(user, "ROLE_USER");

        authWithHttpServletRequest(request, user.getEmail(), password);
        return "redirect:/";
    }


    public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
        try {
            request.login(email, password);
        } catch (ServletException e) {
            System.out.println("Error while login: " + e);
        }
    }


    @RequestMapping("/login")
    public String login(@Valid @ModelAttribute("user") User user,
                        @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        return "index.jsp";
    }


    @RequestMapping(value={"/", "/home"})
    public String home(Principal principal, Model model,
                       @ModelAttribute("book") Book book) {
        String email = principal.getName();
        User user = userService.findByEmail(email);
        model.addAttribute("user", user);
        if(user!=null) {
            if(user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
                model.addAttribute("currentUser", userService.findByEmail(email));
                model.addAttribute("users", userService.allUsers());
                return "adminPage.jsp";
            }
        }
        model.addAttribute("allBooks",bookService.allBooks());
        return "homePage.jsp";
    }

    @PostMapping("/books")
    public String createBook(Model model,
                             Principal principal,
                             @Valid @ModelAttribute("book")Book book,
                             BindingResult result)
    {

        if(result.hasErrors()){
            model.addAttribute("allBooks",bookService.allBooks());
            return "homePage.jsp";
        }
        String email = principal.getName();
        User user = userService.findByEmail(email);
        book.setCreator(user);
        bookService.createBook(book);
        return "redirect:/home";
    }


    @GetMapping("/books/{id}")
    public String editOrInfoPage(@PathVariable("id")Long id, Model model,Principal principal){
        Book book = bookService.findBook(id);
        String email = principal.getName();
        User user = userService.findByEmail(email);
        List<User> userList = userService.getAllByFavorites(book);
        model.addAttribute("book", book);
        model.addAttribute("user", user);
        model.addAttribute("allLikers", userList);
        if(book.getCreator() == user) {

            return "editBook.jsp";
        }
        return "bookInfo.jsp";
    }

    @PutMapping("/books/edit/{id}")
    public String editBook(@PathVariable("id")Long id,
                           Model model,
                           Principal principal,
                           @Valid @ModelAttribute("book")Book book,
                           BindingResult result)
    {
        String email = principal.getName();
        User user = userService.findByEmail(email);
        List<User> userList = userService.getAllByFavorites(book);
        if(result.hasErrors())
        {
            model.addAttribute("allLikers", userList);
            model.addAttribute("user",user);
            return "editBook.jsp";
        }

        book.setCreator(user);
        bookService.update(book,bookService.findBook(id));
        return "redirect:/home";
    }


    @GetMapping("/books/delete/{id}")
    public String deleteBook(@PathVariable("id") Long id){
        bookService.deleteBook(id);
        return "redirect:/home";
    }

    @GetMapping("/addToFavorites/{id}")
    public String addLikeToIdea(@PathVariable("id") Long id, Principal principal){
        Book book = bookService.findBook(id);
        String email = principal.getName();
        User user = userService.findByEmail(email);
        bookService.addToFavorites(book,user);
        return "redirect:/home";
    }

    @GetMapping("/removeFavorites/{id}")
    public String removeBook(@PathVariable("id") Long id, Principal principal){
        Book book = bookService.findBook(id);
        String email = principal.getName();
        User user = userService.findByEmail(email);
        bookService.removeFromFavorite(book,user);
        return "redirect:/home";
    }

}


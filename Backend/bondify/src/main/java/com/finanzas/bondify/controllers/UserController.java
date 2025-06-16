package com.finanzas.bondify.controllers;

import com.finanzas.bondify.dtos.UserDTO;
import com.finanzas.bondify.entities.User;
import com.finanzas.bondify.servicesinterfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.modelmapper.ModelMapper;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private IUserService uS;

    //Por ahora no security hijito
    //@Autowired
    //private PasswordEncoder passwordEncoder;

    @PostMapping
    public void insertUser (@RequestBody UserDTO userDTO){
        ModelMapper m = new ModelMapper();
        User u = m.map(userDTO, User.class);

        //Esto es cuando tengamossecurity
        //String encodedPassword = passwordEncoder.encode(u.getPassword());
        //u.setPassword(encodedPassword);
        uS.insert(u);
    }

    @PutMapping
    public void updateUser (@RequestBody UserDTO userDTO){
        ModelMapper m = new ModelMapper();
        User u = m.map(userDTO, User.class);

        //Esto es cuando tengamossecurity
        //String encodedPassword = passwordEncoder.encode(u.getPassword());
        //u.setPassword(encodedPassword);
        uS.insert(u);
    }

    @GetMapping
    public List<UserDTO> listUsers(){
        return uS.list().stream().map(y->{
            ModelMapper m = new ModelMapper();
            return m.map(y,UserDTO.class);
        }).collect(Collectors.toList());
    }

    @DeleteMapping("/{id}")
    public void deleteUser (@PathVariable("id") Integer id){uS.delete(id);}

    @GetMapping("/{id}")
    public UserDTO getUser (@PathVariable("id") Integer id){
        ModelMapper m = new ModelMapper();
        UserDTO dto = m.map(uS.listId(id), UserDTO.class);
        return dto;
    }

}

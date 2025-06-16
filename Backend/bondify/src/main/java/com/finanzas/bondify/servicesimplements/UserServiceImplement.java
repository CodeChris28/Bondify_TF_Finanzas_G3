package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.User;
import com.finanzas.bondify.repositories.IUserRepository;
import com.finanzas.bondify.servicesinterfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImplement implements IUserService {

    @Autowired
    private IUserRepository uR;

    @Override
    public void insert(User user) { uR.save(user); }

    @Override
    public List<User> list() {  return uR.findAll(); }

    @Override
    public void delete(int id) { uR.deleteById(id);  }

    @Override
    public User findbyEmail(String email) {    return null;    }

    @Override
    public User listId(int id) {   return uR.findById(id).orElse(new User()) ;    }
}

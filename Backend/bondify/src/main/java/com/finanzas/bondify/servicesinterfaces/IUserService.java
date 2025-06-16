package com.finanzas.bondify.servicesinterfaces;

import com.finanzas.bondify.entities.User;

import java.util.List;

public interface IUserService {
    public void insert(User usuario);
    public List<User> list();
    public void delete(int id);
    public User findbyEmail(String email);
    public User listId(int id);

}

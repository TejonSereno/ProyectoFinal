package com.example.demo.dto.usuario;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información para actualizar un usuario")
public class UsuarioUpdateDTO {
    private String nombre;
    private String email;
    private String password;

    public UsuarioUpdateDTO() {
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}

package com.example.demo.dto.usuario;

import com.example.demo.dto.vivienda.ViviendaDTO;
import com.example.demo.models.Usuario;

public class UsuarioDetalleDTO {

    private Long id;
    private String nombre;
    private String email;
    private String password;
    private String rol;
    private ViviendaDTO viviendaDTO;

    public UsuarioDetalleDTO() {
    }

    public UsuarioDetalleDTO(Usuario usuario) {
        this.id = usuario.getId();
        this.nombre = usuario.getNombre();
        this.email = usuario.getEmail();
        this.rol = usuario.getRol();
        this.password = usuario.getPassword();
        this.viviendaDTO = usuario.getVivienda() != null ? new ViviendaDTO(usuario.getVivienda()) : null;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
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

    public String getRol() {
        return rol;
    }
    public void setRol(String rol) {
        this.rol = rol;
    }

    public ViviendaDTO getViviendaDTO() {
        return viviendaDTO;
    }
    public void setViviendaDTO(ViviendaDTO viviendaDTO) {
        this.viviendaDTO = viviendaDTO;
    }
}

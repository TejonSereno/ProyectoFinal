package com.example.demo.dto;

import com.example.demo.dto.usuario.UsuarioDetalleDTO;

public class AuthResponse {

    private String token;
    private UsuarioDetalleDTO usuario;

    public AuthResponse(
            String token,
            UsuarioDetalleDTO usuario
    ) {
        this.token = token;
        this.usuario = usuario;
    }

    public String getToken() {
        return token;
    }

    public UsuarioDetalleDTO getUsuario() {
        return usuario;
    }
}

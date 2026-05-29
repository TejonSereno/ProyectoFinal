package com.example.demo.dto;

import com.example.demo.dto.usuario.UsuarioDetalleDTO;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información devuelta al loguear correctamente")
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

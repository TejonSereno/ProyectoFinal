package com.example.demo.dto.voto;

import com.example.demo.dto.usuario.UsuarioDTO;
import com.example.demo.models.Voto;

public class VotoDetalleDTO {

    private Long id;
    private String opcion;
    private Long votacionId;
    private UsuarioDTO usuario;


    public VotoDetalleDTO(Voto voto) {
        this.id = voto.getId();
        this.opcion = voto.getOpcion();
        this.votacionId = voto.getVotacion().getId();
        this.usuario = voto.getUsuario() != null ? new UsuarioDTO(voto.getUsuario()) : null;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getOpcion() {
        return opcion;
    }
    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }

    public Long getVotacionId() {
        return votacionId;
    }
    public void setVotacionId(Long votacionId) {
        this.votacionId = votacionId;
    }

    public UsuarioDTO getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioDTO usuario) {
        this.usuario = usuario;
    }
}

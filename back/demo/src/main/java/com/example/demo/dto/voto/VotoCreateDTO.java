package com.example.demo.dto.voto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información para crear un voto")
public class VotoCreateDTO {

    private Long votacionId;
    private String opcion;
    private Long usuarioId;

    public VotoCreateDTO() {
    }

    public Long getVotacionId() {
        return votacionId;
    }

    public void setVotacionId(Long votacionId) {
        this.votacionId = votacionId;
    }

    public String getOpcion() {
        return opcion;
    }

    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }
}


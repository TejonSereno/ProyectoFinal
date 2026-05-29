package com.example.demo.dto.voto;

import com.example.demo.models.Voto;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información de un voto")
public class VotoDTO {

    private Long id;
    private String opcion;
    private Long votacionId;

    public VotoDTO(Voto voto) {
        this.id = voto.getId();
        this.opcion = voto.getOpcion();
        this.votacionId = voto.getVotacion().getId();
    }

    public VotoDTO(Long id, String opcion, Long votacionId){
        this.id = id;
        this.opcion = opcion;
        this.votacionId = votacionId;
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
}

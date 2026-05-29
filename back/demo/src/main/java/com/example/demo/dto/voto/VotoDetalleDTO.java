package com.example.demo.dto.voto;

import com.example.demo.dto.usuario.UsuarioDTO;
import com.example.demo.models.Voto;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información detallada de un voto")
public class VotoDetalleDTO {

    @Schema(example = "1")
    private Long id;

    @Schema(example = "Si")
    private String opcion;

    @Schema(example = "1")
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

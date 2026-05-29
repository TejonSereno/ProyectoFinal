package com.example.demo.dto.vivienda;


import com.example.demo.dto.usuario.UsuarioDTO;
import com.example.demo.models.Vivienda;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

@Schema(description = "Información detallada de una vivienda")
public class ViviendaDetalleDTO {

    @Schema(example = "1")
    private Long id;

    @Schema(example = "Calle Mayor")
    private String calle;

    @Schema(example = "1")
    private String numero;

    @Schema(example = "1")
    private Long comunidadId;

    private List<UsuarioDTO> usuarios;

    public ViviendaDetalleDTO() {
    }

    public ViviendaDetalleDTO(Vivienda vivienda) {
        this.id = vivienda.getId();
        this.calle = vivienda.getCalle();
        this.numero = vivienda.getNumero();
        this.comunidadId = vivienda.getComunidad().getId();
        this.usuarios = vivienda.getUsuarios().stream().map(UsuarioDTO::new).toList();
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getCalle() {
        return calle;
    }
    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNumero() {
        return numero;
    }
    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Long getComunidadId() {
        return comunidadId;
    }
    public void setComunidadId(Long comunidadId) {
        this.comunidadId = comunidadId;
    }

    public List<UsuarioDTO> getUsuarios() {
        return usuarios;
    }
    public void setUsuarios(List<UsuarioDTO> usuarios) {
        this.usuarios = usuarios;
    }
}

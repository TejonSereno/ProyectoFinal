package com.example.demo.dto.comunidad;

import com.example.demo.dto.incidencia.IncidenciaDTO;
import com.example.demo.dto.usuario.UsuarioDTO;
import com.example.demo.dto.vivienda.ViviendaDTO;
import com.example.demo.dto.votacio.VotacionDTO;
import com.example.demo.models.Comunidad;

import java.util.List;

public class ComunidadDetalleDTO {

    private Long id;
    private String nombre;
    private String direccion;
    private List<UsuarioDTO> usuarios;
    private List<ViviendaDTO> viviendas;
    private List<VotacionDTO> votaciones;
    private List<IncidenciaDTO> incidencias;

    public ComunidadDetalleDTO() {
    }

    public ComunidadDetalleDTO(Comunidad comunidad) {
        this.id = comunidad.getId();
        this.nombre = comunidad.getNombre();
        this.direccion = comunidad.getDireccion();
        this.usuarios = comunidad.getUsuarios()
                .stream().map(UsuarioDTO::new).toList();
        this.viviendas = comunidad.getViviendas()
                .stream().map(ViviendaDTO::new).toList();
        this.votaciones = comunidad.getVotaciones()
                .stream().map(VotacionDTO::new).toList();
        this.incidencias = comunidad.getIncidencias()
                .stream().map(IncidenciaDTO::new).toList();
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

    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public List<UsuarioDTO> getUsuarios() {
        return usuarios;
    }
    public void setUsuarios(List<UsuarioDTO> usuarios) {
        this.usuarios = usuarios;
    }

    public List<ViviendaDTO> getViviendas() {
        return viviendas;
    }
    public void setViviendas(List<ViviendaDTO> viviendas) {
        this.viviendas = viviendas;
    }

    public List<VotacionDTO> getVotaciones() {
        return votaciones;
    }
    public void setVotaciones(List<VotacionDTO> votaciones) {
        this.votaciones = votaciones;
    }

    public List<IncidenciaDTO> getIncidencias() {
        return incidencias;
    }
    public void setIncidencias(List<IncidenciaDTO> incidencias) {
        this.incidencias = incidencias;
    }
}

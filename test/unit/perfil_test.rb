# encoding: utf-8
require './test/test_helper'

class PerfilTest < ActiveSupport::TestCase

  test "debería prohibir guardar perfiles sin fecha" do
    c = Perfil.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    assert build_stubbed(:perfil_futuro).invalid?, "la fecha es del futuro"
  end

  test "debería cargar el paisaje asociado" do
    atributos = attributes_for(:perfil).merge(
      paisaje_attributes: { simbolo: "Ps" })
    assert_difference 'Paisaje.count' do
      c = Perfil.create(atributos)
      refute c.errors.any?
      assert c.valid?, "No valida"
    end
  end

  test "debería cargar la ubicación asociada" do
    atributos = attributes_for(:perfil).merge(
      ubicacion_attributes: { descripcion: "Somewhere over the rainbow" } )
    assert_difference 'Ubicacion.count' do
      c = Perfil.create(atributos)
      refute c.errors.any?
      assert c.valid?, "No valida"
    end
  end

  test "debería crear una serie cuando no existe" do
    assert_difference 'Serie.count', 1, "No crea la serie a partir del perfil" do
      create :perfil,
        serie_attributes: attributes_for(:serie).slice(:nombre, :simbolo)
    end
  end

  test "debería crear una fase cuando no existe" do
    assert_difference 'Fase.count', 1, "No crea la fase a partir del perfil" do
      create :perfil,
        fase_attributes: attributes_for(:fase).slice(:nombre)
    end
  end

  test "debería crear un grupo cuando no existe" do
    assert_difference 'Grupo.count', 1, "No crea el grupo a partir del perfil" do
      create :perfil,
        grupo_attributes: attributes_for(:grupo).slice(:descripcion)
    end
  end

  test "debería asociar una serie si existe" do
    serie = create(:serie)
    assert_no_difference 'Serie.count', "Crea una serie nueva" do
      perfil = create :perfil,
        serie_attributes: serie.serializable_hash.slice("nombre", "simbolo")
      assert_equal serie, perfil.serie, "No le carga la serie existente"
    end
  end

  test "debería asociar una fase si existe" do
    fase = create(:fase)
    assert_no_difference 'Fase.count', "Crea una fase nueva" do
      perfil = create :perfil,
        attributes_for(:perfil).merge(fase_attributes: fase.serializable_hash.slice("nombre"))
      assert_equal fase, perfil.fase, "No le carga la fase existente"
    end
  end

  test "debería asociar un grupo si existe" do
    grupo = create(:grupo)
    assert_no_difference 'Grupo.count', "Crea un grupo nuevo" do
      perfil = create :perfil,
        grupo_attributes: grupo.serializable_hash.slice("descripcion")
      assert_equal grupo, perfil.grupo, "No le carga el grupo existente"
    end
  end

end
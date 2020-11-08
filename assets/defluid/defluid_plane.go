components {
  id: "defluid_color"
  component: "/assets/defluid/defluid_color.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "fluid_color"
    value: "0.0, 0.5, 0.8, 0.5"
    type: PROPERTY_TYPE_VECTOR4
  }
}
embedded_components {
  id: "model"
  type: "model"
  data: "mesh: \"/assets/defluid/plane.dae\"\n"
  "material: \"/assets/defluid/render target.material\"\n"
  "skeleton: \"\"\n"
  "animations: \"\"\n"
  "default_animation: \"\"\n"
  "name: \"unnamed\"\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace PRACTICA_MANEJOARCHIVOS.Classes
{
    [Serializable]
    public class Persona
    {
        [XmlAttribute]
        [SoapAttribute]
        public string Nombre { get; set; }
        [XmlAttribute]
        [SoapAttribute]
        public string Apellidos { get; set; }
        [XmlAttribute]
        [SoapAttribute]
        public string Direccion { get; set; }
        [XmlAttribute]
        [SoapAttribute]
        public string Edad { get; set; }
        [XmlAttribute(DataType = "date")]
        [SoapAttribute(DataType = "date")]
        public DateTime FechaNacimiento { get; set; }

        [XmlArray]
        [SoapIgnore]
        public List<Documento> Documentos { get; set; }

    }
}

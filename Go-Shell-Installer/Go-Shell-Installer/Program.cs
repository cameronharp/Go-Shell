using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Go_Shell_Installer
{
    class Program
    {
        static void Main(string[] args)
        {
            var powerShellPath = String.Format("{0}\\WindowsPowerShell", Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));

            if(File.Exists(powerShellPath))
            {
                
            }

            Console.ReadKey();
        }
    }
}

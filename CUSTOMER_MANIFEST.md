---
deployment_manifest:
  entity: "Woodfine Management Corp."
  role: "Customer"
  primary_terminal: "Woodfine-Command-Centre"
  network_type: "Private Network"

deployment_matrix:
  command:
    - name: "route-network-admin"
      module: "Network-Admin-OS"
      hardware: "Woodfine-Command-Centre"
  orchestration:
    - name: "gateway-interface-command"
      module: "Interface-OS"
      connections: ["cluster-totebox-corporate", "cluster-totebox-real-property"]
    - name: "cluster-totebox-personnel"
      module: "Totebox-OS"
      status: "Standalone"
  user_access_orchestrated:
    - name: "node-console-email"
      gateway: "gateway-interface-command"
    - name: "node-console-people"
      gateway: "gateway-interface-command"
    - name: "node-console-proofreader"
      target: "cluster-totebox-personnel"
  user_access_terminal_direct:
    - names: ["vault-privategit-design", "vault-privategit-source"]
      access_mode: "TUI / Direct Terminal"
    - names: ["media-marketing-landing", "media-knowledge-corporate", "media-knowledge-projects", "media-distribution-news"]
      access_mode: "TUI / Direct Terminal"
---

# Customer Manifest | Manifiesto del Cliente

## 🏢 Fleet Operations | Operaciones de la Flota
Woodfine Management Corp. utilizes specialized deployments to manage the real property lifecycle. The **Woodfine-Command-Centre** serves as the central node for orchestration and independent system testing.

Woodfine Management Corp. utiliza despliegues especializados para gestionar el ciclo de vida de los bienes inmuebles. El **Woodfine-Command-Centre** sirve como nodo central para la orquestación y las pruebas de sistemas independientes.

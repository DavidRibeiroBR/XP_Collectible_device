# XP Collector Device 2.0 (Verse - UEFN)

Este repositório contém um script em **Verse** para o **Unreal Editor for Fortnite (UEFN)**. O código gerencia de forma modular o sistema de coleta de itens, concedendo XP aos jogadores através de dispositivos de reconhecimento (*Accolades*) e automatizando o tempo de reaparecimento (*respawn*) dos colecionáveis agrupados.

## 🚀 Funcionalidades

* **Grupos Modulares de Colecionáveis:** Permite organizar os itens em diferentes grupos diretamente pelo editor do UEFN.
* **XP Personalizado por Grupo:** Cada grupo de colecionáveis pode ter seu próprio dispositivo de *Accolade* configurado para recompensar o jogador com quantidades específicas de XP.
* **Tempo de Respawn Individual:** Cada grupo define seu próprio tempo de espera antes que os itens coletados reapareçam para todos os jogadores.
* **Gerenciamento Concorrente:** Utiliza recursos assíncronos do Verse (`<suspends>` e `spawn`) para lidar com o temporizador de respawn de forma independente para cada item coletado.

---

## 💻 Estrutura do Código

O script é composto por três estruturas principais:

1. **`collectible_group` (Classe Concreta):**
   * Agrupa uma lista de dispositivos `collectible_object_device`.
   * Define a variável `RespawnTime` (tempo em segundos).
   * Associa um `accolades_device` exclusivo para o grupo.

2. **`xp_collector_device2` (Dispositivo Criativo Principal):**
   * Herda de `creative_device`.
   * Expõe a lista de `Groups` configurável no editor.
   * Na inicialização (`OnBegin`), itera sobre todos os grupos e colecionáveis, registrando os manipuladores de eventos de coleta (`CollectedEvent`).

3. **`respawn_handler` (Classe Auxiliar):**
   * Controla a lógica individual de quando um item é coletado.
   * Concede o XP chamando `Accolade.Award(Collector)`.
   * Pausa a execução pelo tempo determinado (`Sleep`) e reativa o colecionável globalmente (`Collectible.RespawnForAll()`).

---

## 🛠️ Como Usar no UEFN

1. Crie ou abra um projeto no **Unreal Editor for Fortnite**.
2. Crie um novo script Verse (ou cole este código em um arquivo `.verse` existente do seu projeto).
3. Adicione o dispositivo principal (`xp_collector_device2`) à sua ilha.
4. No painel de detalhes (*Details*) do dispositivo no editor:
   * Adicione novos elementos na lista **Groups**.
   * Insira os seus dispositivos colecionáveis (*Collectible Object Devices*) no array correspondente de cada grupo.
   * Configure o tempo desejado em **Respawn Time**.
   * Arraste e vincule o dispositivo de XP (*Accolades Device*) correspondente ao campo **Accolade**.
5. Compile o código Verse e teste a ilha no modo de jogo.

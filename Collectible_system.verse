using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# Define um grupo de colecionáveis com um tempo de respawn e um accolade (XP) próprios.
collectible_group := class<concrete>:
    @editable
    Collectibles : []collectible_object_device = array{}

    @editable
    RespawnTime : float = 45.0

    # Cada grupo agora tem seu próprio dispositivo de accolade para XP.
    @editable
    Accolade : accolades_device = accolades_device{}

# Dispositivo principal que gerencia a coleta, o XP e o respawn modular.
xp_collector_device2 := class(creative_device):

    # Array de grupos de colecionáveis. Configure cada grupo no editor.
    @editable
    Groups : []collectible_group = array{}

    # Executado quando o jogo começa.
    OnBegin<override>()<suspends>:void =
        # Itera sobre cada grupo definido no editor.
        for (Group : Groups):
            # Para cada colecionável dentro do grupo, inscreve-se no seu evento de coleta.
            for (Collectible : Group.Collectibles):
                # O handler agora recebe o accolade específico do grupo.
                Handler := respawn_handler{
                    Collectible := Collectible,
                    RespawnTime := Group.RespawnTime,
                    Accolade := Group.Accolade
                }
                Collectible.CollectedEvent.Subscribe(Handler.OnCollected)

# Classe auxiliar que lida com a coleta de um item específico.
# (Nenhuma mudança necessária nesta classe)
respawn_handler := class:
    Collectible : collectible_object_device
    RespawnTime : float
    Accolade : accolades_device

    # Chamado quando o item específico desta instância é coletado.
    OnCollected(Collector : agent):void =
        # Concede XP ao jogador que coletou o item.
        Accolade.Award(Collector)
        Print("Item coletado")
        # Inicia o processo de respawn em uma tarefa separada.
        spawn { RespawnItem() }
        

    # Aguarda o tempo de respawn e reativa o item.
    RespawnItem()<suspends>:void =
        Sleep(RespawnTime)
        # Reativa o item para todos os jogadores.
        Collectible.RespawnForAll()
        Print("Item respawned for all players.")

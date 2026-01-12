​📖 GUIA OFICIAL: LORELIB ULTRA 2026 (RLK EDITION)
​Este tutorial ensina como usar a biblioteca LoreLib seguindo o padrão de codificação do Randola, incluindo a hierarquia de UI, sistema de Save e carregamento via loadstring.
​1. CARREGAMENTO INICIAL
Todo script deve começar puxando a biblioteca do GitHub:
local LoreLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lorenzodev12345678/LoreLib/refs/heads/main/main.lua"))()
​2. CRIANDO A JANELA (WINDOW)
A janela é o container principal. Você define o título, o sub-título e a cor principal (Drip Style).
​Comando: local Window = LoreLib:CreateWindow("Título", "Subtítulo", Color3.fromRGB(r, g, b))
​Exemplo: local Win = LoreLib:CreateWindow("LoreLib | Brookhaven", "Main", Color3.fromRGB(0, 255, 120))
​3. CRIANDO ABAS (TABS)
As abas organizam as categorias do seu script. Elas ficam dentro da Window.
​Comando: local Tab = Window:CreateTab("Nome da Aba")
​Exemplo: local PlayerTab = Win:CreateTab("Player")
​4. CRIANDO BOTÕES (BUTTONS)
O botão executa a função que você programar. Ele deve ser criado dentro de uma Tab.
​Comando: Tab:CreateButton("Texto", function() ... end)
​Exemplo: PlayerTab:CreateButton("Velocidade 50", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
​5. PADRÃO RLK DE QUALIDADE (SAVE & SCRIPTS)
Para o script ser considerado Ultra 2026, ele deve:
​Auto-Save: Em toda função de botão, chame a função SaveData() para guardar a config na pasta Lorelib_Data.
​Intro: Rodar as frases "Você nem é dev", etc., antes da UI aparecer.
​Hub de Scripts: Sempre ter uma aba com botões de atalho para LoreTcs e LoreBody.
​Exemplo de Estrutura Rápida:local LoreLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lorenzodev12345678/LoreLib/refs/heads/main/main.lua"))()
local Win = LoreLib:CreateWindow("LoreLib 2026", "rlk", Color3.fromRGB(0, 255, 120))
local Tab = Win:CreateTab("Geral")
Tab:CreateButton("Ativar", function() print("Rodando!") end)

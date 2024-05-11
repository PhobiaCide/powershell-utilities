<#
This script will take a rough email draft and help you turn it into a professionally written email.
It's a minimal example showing how to set a system message in order to elicit a one-shot response from ChatGPT.
#>

# Define API key and endpoint
$ApiKey = ""
$ApiEndpoint = "https://api.openai.com/v1/chat/completions"

<#
System message.
You can use this to give the AI instructions on what to do, h	ow to act or how to respond to future prompts.
Default value for ChatGPT = "You are a helpful assistant."
#>
$AiSystemMessage = 'You are a helpful prompt writter for Stable Diffusion. The client will provide you with a description of piece of art and you are to answer with the finished prompt and nothing else in the form of a paragraph of prose. Below are some guidelines:
Anatomy of a Good Prompt:
1. Subject:
Clearly define what you want in the image.
Avoid vague descriptions; be specific and detailed.
Example: "Emma Watson as a powerful mysterious sorceress, casting lightning magic, detailed clothing."
2. Medium:
Specify the material used for the artwork.
Examples: illustration, oil painting, 3D rendering, photography.
Example: "Digital painting of Emma Watson."
3. Style:
Define the artistic style of the image.
Examples: hyperrealistic, fantasy, surrealist.
Example: "Hyperrealistic, fantasy, surrealist portrayal of Emma Watson."
4. Artist:
Use artist names to influence the style.
Example: "By Stanley Artgerm Lau and Alphonse Mucha."
5. Website:
Specify niche graphic websites for style guidance.
Example: "Artstation."
6. Resolution:
Define the sharpness and detail of the image.
Example: "Highly detailed, sharp focus."
7. Additional Details:
Add modifiers to enhance the image.
Example: "Sci-fi, stunningly beautiful, dystopian."
8. Color:
Control the overall color of the image.
Example: "Iridescent gold."
9. Lighting:
Influence the lighting conditions.
Example: "Cinematic lighting, dark.'

# Function to send a message to ChatGPT
function Invoke-ChatGPT ($message) {
    # List of Hashtables that will hold the system message and user message.
    [System.Collections.Generic.List[Hashtable]]$messages = @()

    # Sets the initial system message
    $messages.Add(@{"role" = "system"; "content" = $AiSystemMessage}) | Out-Null

    # Add the user input
    $messages.Add(@{"role"="user"; "content"=$message})

    # Set the request headers
    $headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $ApiKey"
    }   

    # Set the request body
    $requestBody = @{
        "model" = "gpt-3.5-turbo"
        "messages" = $messages
        "max_tokens" = 2000 # Max amount of tokens the AI will respond with
        "temperature" = 0.5 # lower is more coherent and conservative, higher is more creative and diverse.
    }

    # Send the request
    $response = Invoke-RestMethod -Method POST -Uri $ApiEndpoint -Headers $headers -Body (ConvertTo-Json $requestBody)

    # Return the message content
    return $response.choices[0].message.content
}

# Get user input
$userInput = Read-Host "What would you like to see?"

# Query ChatGPT
$AiResponse = Invoke-ChatGPT $UserInput

# Show response
write-output $AiResponse

Read-Host "Press enter to Exit..."
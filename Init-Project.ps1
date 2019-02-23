#Init-Project -type "html5" -name "xxx"

#$argType = $args[0]

Param (
        [Parameter(Mandatory =$true)]
        [string]$Type = '',

        [Parameter(Mandatory =$true)]
        [string]$Name
)

$htmlContent = 

@"
<!doctype html>
<html>
    <head>
        <title>$Name</title>
    </head>
    <body>
        <script type=\"text/javascript\" src=\"js/app.js\"></script>
    </body>
</html>
"@;

mkdir $Name
cd $Name

if ($Type.ToLower() -eq "html5") {
    mkdir js
    mkdir img
    mkdir css
    mkdir misc
        
    new-item ./index.html -itemtype file
    new-item ./js/app.js -ItemType file
    new-item ./css/styles.css -ItemType file

    add-content ./index.html $htmlContent
} else {
}
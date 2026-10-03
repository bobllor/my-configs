function dlp{
    <#
        .DESCRIPTION 
            Automatically installs a given URL as an MP4 file in the best sound
            and video quality to the default downloads folder for Windows.

            yt-dlp must be installed on the system.
        
        .PARAMETER Url
            The URL to the video.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string] $Url
    )

    if(-not $Url){
        echo "Must provide a URL"
        exit 1
    }

    try{
        yt-dlp --version | out-null
    }catch{
        echo "yt-dlp is not installed on the system, see https://github.com/yt-dlp/yt-dlp/wiki/Installation for installation"
        exit 1
    }

    $downloadPath = (new-object -ComObject shell.application).namespace("shell:downloads").self.path

    yt-dlp "$Url" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --paths "$downloadPath"
}
#!/usr/bin/env fish
function clone-up

    if test (count $argv) -ne 2
        echo "Usage: clone-up  <repository_url> <directory>"
        exit 1
    end

    set url $argv[1]
    set dir $argv[2]

    if not test -d $dir
        git clone --depth 1 $url $dir
        echo "✅ $dir Cloned"
    else
        cd $dir
        git pull
        echo "✅ $dir updated"
        prevd
    end

end


function install-fooocus-mre_comfyui

    set COMFY_COMMIT_HASH 2381d36e6db8e8150e42ff2ede628db5b00ae26f

    if test -d ./mount/repositories/ComfyUI-from-StabilityAI-Official
        echo '✅ ./mount/repositories/ComfyUI-from-StabilityAI-Official exists'
        return
    end

    clone-up ./mount/repositories/ComfyUI-from-StabilityAI-Official https://github.com/comfyanonymous/ComfyUI
    cd ./mount/repositories/ComfyUI-from-StabilityAI-Official
    git checkout $COMFY_COMMIT_HASH
    prevd
end

function fooocus_sync_prompt_expansion

    if not test -d ./mount/storage
        echo "❌ Please link storage folder to ./mount/storage"
        exit 1
    end

    rsync --ignore-existing -av \
        Fooocus-MRE/models/prompt_expansion/fooocus_expansion/ \
        mount/models/prompt_expansion/fooocus_expansion/
    echo "✅ mount/models/prompt_expansion/fooocus_expansion/ synced"
end

function install-fooocus-mre
    clone-up https://github.com/MoonRide303/Fooocus-MRE.git Fooocus-MRE
    install-fooocus-mre_comfyui
    fooocus_sync_prompt_expansion
end



function install-comfy-ui
    clone-up https://github.com/comfyanonymous/ComfyUI.git ComfyUI

    # Custom nodes
    clone-up https://github.com/ltdrdata/ComfyUI-Manager.git            ./mount/custom_nodes/ComfyUI-Manager
    clone-up https://github.com/ltdrdata/ComfyUI-Impact-Pack.git        ./mount/custom_nodes/ComfyUI-Impact-Pack
    clone-up https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git       ./mount/custom_nodes/ComfyUI-Inspire-Pack
    clone-up https://github.com/Fannovel16/comfyui_controlnet_aux.git   ./mount/custom_nodes/Comfyui-Controlnet-Auxs
    # clone-up https://github.com/BlenderNeko/ComfyUI_TiledKSampler.git ./mount/custom_nodes/ComfyUI_TiledKSample
    clone-up https://github.com/WASasquatch/FreeU_Advanced.git          ./mount/custom_nodes/FreeU_Advanced

    # clone-up https://github.com/laksjdjf/IPAdapter-ComfyUI.git  ./mount/custom_nodes/IPAdapter-ComfyUI
    clone-up https://github.com/cubiq/ComfyUI_IPAdapter_plus.git        ./mount/custom_nodes/ComfyUI_IPAdapter_plus
    clone-up https://github.com/WASasquatch/was-node-suite-comfyui.git  ./mount/custom_nodes/was-node-suite-comfyui
    clone-up https://github.com/SeargeDP/SeargeSDXL.git                 ./mount/custom_nodes/SeargeSDXL
    # clone-up https://github.com/BlenderNeko/ComfyUI_Cutoff ./mount/custom_nodes/ComfyUI_Cutoff
    # clone-up https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git ./mount/custom_nodes/ComfyUI-Frame-Interpolation

end

install-fooocus-mre
install-comfy-ui
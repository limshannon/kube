#! /bin/sh

function main {
    echo "----- JOB DETAILS -----"
    echo -e "\tWorking Directory: '$(pwd)'"
    downloadBoeingCerts
}

function downloadBoeingCerts {
    mkdir -p ./base/certs
    echo "----- DOWNLOADING BOEING CERTS -----"
    downloadCert "BoeingBasicAssuranceHardwareRootCA" Boeing%20Basic%20Assurance%20Hardware%20Root%20CA.crt
    downloadCert "BoeingBasicAssuranceSoftwareRootCAG2" Boeing%20Basic%20Assurance%20Software%20Root%20CA%20G2.crt
    downloadCert "BoeingBasicAssuranceSoftwareIssuingCAG3" Boeing%20Basic%20Assurance%20Software%20Issuing%20CA%20G3.crt
    downloadCert "BoeingSecureBadgeBasicG2" Boeing%20SecureBadge%20Basic%20G2.crt
    downloadCert "BoeingSecureBadgeMediumG2" Boeing%20SecureBadge%20Medium%20G2.crt
    downloadCert "TheBoeingCompanyClass2CertificateAuthorityG2" The%20Boeing%20Company%20Class%202%20Certificate%20Authority%20G2.crt
    downloadCert "TheBoeingCompanyRootCertificateAuthority" The%20Boeing%20Company%20Root%20Certificate%20Authority.crt
    echo "----- DOWNLOAD COMPLETE -----"
}

function downloadCert {
    echo -ne "\t$1"; \
    curl -q http://www.boeing.com/crl/$2 -o ./base/certs/$1.crt
    curlExitCode=$?
    if [ $curlExitCode -eq 0 ]
    then
        echo "......Downloaded"
    else
        echo "......Failed"
        exit $curlExitCode
    fi
}
main $@
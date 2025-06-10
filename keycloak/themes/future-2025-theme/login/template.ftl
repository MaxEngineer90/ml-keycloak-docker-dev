<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script>
        // Inline JavaScript to avoid loading issues
        document.addEventListener('DOMContentLoaded', function() {
            // Password toggle functionality
            function togglePassword() {
                const passwordField = document.getElementById('password');
                const eyeOpen = document.getElementById('eye-open');
                const eyeClosed = document.getElementById('eye-closed');
                
                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    eyeOpen.style.display = 'none';
                    eyeClosed.style.display = 'block';
                } else {
                    passwordField.type = 'password';
                    eyeOpen.style.display = 'block';
                    eyeClosed.style.display = 'none';
                }
            }
            
            // Make toggle function global
            window.togglePassword = togglePassword;
            
            // Focus first input
            const firstInput = document.querySelector('input:not([type="hidden"])');
            if (firstInput) {
                setTimeout(() => firstInput.focus(), 100);
            }
        });
    </script>
</head>

<body class="${properties.kcBodyClass!}">
    <div class="login-container">
        <div class="login-background">
            <div class="gradient-overlay"></div>
        </div>
        
        <div class="login-content">
            <div class="login-box">
                <div class="login-header">
                    <div class="login-logo">
                        <img src="${url.resourcesPath}/img/logo.svg" alt="Logo" class="logo-image" />
                    </div>
                    <#if realm.displayName??>
                        <h1 class="login-title">${realm.displayName}</h1>
                    <#else>
                        <h1 class="login-title">Welcome</h1>
                    </#if>
                    <#if realm.displayNameHtml??>
                        <div class="login-subtitle">${realm.displayNameHtml?no_esc}</div>
                    </#if>
                </div>

                <div id="kc-content">
                    <div id="kc-content-wrapper">
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <div class="alert alert-${message.type}">
                                <#if message.type = 'success'><span class="kc-feedback-icon fa fa-check-circle"></span></#if>
                                <#if message.type = 'warning'><span class="kc-feedback-icon fa fa-exclamation-triangle"></span></#if>
                                <#if message.type = 'error'><span class="kc-feedback-icon fa fa-exclamation-circle"></span></#if>
                                <#if message.type = 'info'><span class="kc-feedback-icon fa fa-info-circle"></span></#if>
                                <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                            </div>
                        </#if>

                        <#nested "form">

                        <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                <div class="try-another-way">
                                    <input type="hidden" name="tryAnotherWay" value="on"/>
                                    <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                </div>
                            </form>
                        </#if>

                        <#if displayInfo>
                            <div id="kc-info" class="${properties.kcSignUpClass!}">
                                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                    <#nested "info">
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
</#macro>
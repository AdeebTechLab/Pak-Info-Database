import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum ViewMode { Mobile, Desktop }

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  ViewMode currentMode = ViewMode.Mobile;
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted && isLoading) {
                  setState(() {
                    isLoading = false;
                  });
                  _updateNavigationState();
                }
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              hasError = false;
              errorMessage = '';
            });
          },
          onPageFinished: (String url) async {
            if (!mounted) return;
            setState(() {
              isLoading = false;
            });
            _updateNavigationState();

            // Simple mode injection - only if needed
            if (currentMode == ViewMode.Desktop) {
              await Future.delayed(const Duration(milliseconds: 1000));
              _injectSimpleDesktopCSS();
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Only handle main frame errors
            if (error.isForMainFrame ?? true) {
              setState(() {
                isLoading = false;
                hasError = true;
                errorMessage = _getErrorMessage(error);
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    _loadUrlWithUserAgent();
  }

  void _loadUrlWithUserAgent() {
    String userAgent = _getUserAgentForMode(currentMode);
    String url = widget.url;

    // Ensure URL has protocol
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    // Simple URL modifications for desktop mode
    if (currentMode == ViewMode.Desktop) {
      url = _getDesktopUrl(url);
    }

    controller.setUserAgent(userAgent).then((_) {
      controller.loadRequest(Uri.parse(url));
    }).catchError((error) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Failed to load the webpage';
      });
    });
  }

  String _getDesktopUrl(String url) {
    // Convert mobile URLs to desktop versions
    if (url.contains('m.facebook.com')) {
      return url.replaceAll('m.facebook.com', 'www.facebook.com');
    }
    if (url.contains('mobile.twitter.com')) {
      return url.replaceAll('mobile.twitter.com', 'twitter.com');
    }
    if (url.contains('m.reddit.com')) {
      return url.replaceAll('m.reddit.com', 'www.reddit.com');
    }
    return url;
  }

  String _getUserAgentForMode(ViewMode mode) {
    switch (mode) {
      case ViewMode.Mobile:
        return 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1';
      case ViewMode.Desktop:
        return 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36';
    }
  }

  void _injectSimpleDesktopCSS() {
    // Very minimal CSS injection - only basic scaling
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth > 600 ? 0.8 : 0.6;

    controller.runJavaScript('''
      try {
        var existingStyle = document.getElementById('flutter-desktop-style');
        if (existingStyle) existingStyle.remove();
        
        var style = document.createElement('style');
        style.id = 'flutter-desktop-style';
        style.innerHTML = `
          body {
            zoom: $scale !important;
            min-width: 1000px !important;
          }
          * {
            -webkit-text-size-adjust: none !important;
          }
        `;
        document.head.appendChild(style);
      } catch(e) {
        console.log('CSS injection failed:', e);
      }
    ''').catchError((e) => print('CSS injection failed: $e'));
  }

  void _switchMode(ViewMode mode) {
    if (currentMode != mode) {
      setState(() {
        currentMode = mode;
        isLoading = true;
        hasError = false;
        errorMessage = '';
      });
      _loadUrlWithUserAgent();
    }
  }

  Future<void> _updateNavigationState() async {
    try {
      final back = await controller.canGoBack();
      final forward = await controller.canGoForward();
      if (mounted) {
        setState(() {
          canGoBack = back;
          canGoForward = forward;
        });
      }
    } catch (e) {
      print('Navigation state update failed: $e');
    }
  }

  void _refresh() {
    setState(() {
      hasError = false;
      errorMessage = '';
      isLoading = true;
    });
    controller.reload();
  }

  void _retryConnection() {
    setState(() {
      hasError = false;
      errorMessage = '';
      isLoading = true;
    });
    _loadUrlWithUserAgent();
  }

  String _getErrorMessage(WebResourceError error) {
    switch (error.errorType) {
      case WebResourceErrorType.hostLookup:
        return 'Website not found. Please check the URL.';
      case WebResourceErrorType.timeout:
        return 'Connection timed out. Please try again.';
      case WebResourceErrorType.connect:
        return 'Cannot connect to the website.';
      case WebResourceErrorType.fileNotFound:
        return 'Page not found.';
      default:
        return 'Unable to load the webpage. This might be because:\n• The website doesn\'t support desktop view\n• The site has restrictions\n• Network connection issue';
    }
  }

  void _goBack() {
    if (canGoBack) {
      controller.goBack();
    }
  }

  void _goForward() {
    if (canGoForward) {
      controller.goForward();
    }
  }

  Color _getModeColor(ViewMode mode, ThemeManager themeManager) {
    if (mode == ViewMode.Mobile) {
      return themeManager.isDarkMode ? Colors.blue.shade400 : Colors.blue;
    } else {
      return themeManager.isDarkMode ? Colors.orange.shade400 : Colors.orange;
    }
  }

  IconData _getModeIcon(ViewMode mode) {
    return mode == ViewMode.Mobile ? Icons.smartphone : Icons.desktop_windows;
  }

  Widget _buildErrorPage(ThemeManager themeManager) {
    return Container(
      color: themeManager.backgroundColor,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red[400],
              ),
              const SizedBox(height: 24),
              Text(
                'Unable to Load Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeManager.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: themeManager.textColor.withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (currentMode == ViewMode.Desktop) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: themeManager.isDarkMode
                        ? Colors.amber[900]?.withOpacity(0.2)
                        : Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: themeManager.isDarkMode
                            ? Colors.amber[600]!
                            : Colors.amber[200]!
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                          Icons.info_outline,
                          color: themeManager.isDarkMode
                              ? Colors.amber[400]
                              : Colors.amber[700],
                          size: 20
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Try switching to Mobile mode - some websites work better in mobile view',
                          style: TextStyle(
                            color: themeManager.isDarkMode
                                ? Colors.amber[400]
                                : Colors.amber[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _retryConnection,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text('Try Again', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getModeColor(currentMode, themeManager),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      if (currentMode == ViewMode.Desktop) {
                        _switchMode(ViewMode.Mobile);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      currentMode == ViewMode.Desktop ? Icons.smartphone : Icons.arrow_back,
                      color: _getModeColor(currentMode, themeManager),
                    ),
                    label: Text(
                      currentMode == ViewMode.Desktop ? 'Try Mobile' : 'Go Back',
                      style: TextStyle(color: _getModeColor(currentMode, themeManager)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _getModeColor(currentMode, themeManager)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModeSelector(ThemeManager themeManager) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeManager.cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: themeManager.textColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.visibility, color: _getModeColor(currentMode, themeManager)),
                    const SizedBox(width: 12),
                    Text(
                      'Select View Mode',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeManager.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              ...ViewMode.values.map((mode) {
                bool isSelected = currentMode == mode;
                Color modeColor = _getModeColor(mode, themeManager);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? modeColor : themeManager.textColor.withOpacity(0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected ? modeColor.withOpacity(0.1) : null,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: modeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(_getModeIcon(mode), color: modeColor, size: 24),
                    ),
                    title: Text(
                      mode.name.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? modeColor : themeManager.textColor,
                      ),
                    ),
                    subtitle: Text(
                      _getDescriptionForMode(mode),
                      style: TextStyle(
                        color: isSelected
                            ? modeColor.withOpacity(0.8)
                            : themeManager.textColor.withOpacity(0.6),
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: modeColor, size: 24)
                        : Icon(
                        Icons.radio_button_unchecked,
                        color: themeManager.textColor.withOpacity(0.4),
                        size: 24
                    ),
                    onTap: () {
                      _switchMode(mode);
                      Navigator.pop(context);
                      HapticFeedback.lightImpact();
                    },
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  String _getDescriptionForMode(ViewMode mode) {
    switch (mode) {
      case ViewMode.Mobile:
        return 'Mobile-optimized view (recommended)';
      case ViewMode.Desktop:
        return 'Desktop view (may not work on all sites)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeManager.primaryColor,
        title: Text(
          "${currentMode.name.toLowerCase()} View",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showModeSelector(themeManager),
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (!hasError) WebViewWidget(controller: controller),
          if (hasError) _buildErrorPage(themeManager),
          if (isLoading && !hasError)
            Container(
              color: themeManager.backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: _getModeColor(currentMode, themeManager)),
                    const SizedBox(height: 16),
                    Text(
                      'Loading ${currentMode.name} view...',
                      style: TextStyle(
                          color: _getModeColor(currentMode, themeManager),
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
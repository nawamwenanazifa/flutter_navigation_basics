import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ============================================================
// CONCEPT 7: go_router - Declarative Routing
// Following Week 2 Lesson: go_router, Deep Linking & Route Guards
// ============================================================
// Demonstrates:
// 1. URL-based routing with real paths
// 2. Path parameters (/product/:id)
// 3. Query parameters (/search?q=)
// 4. Route guards with redirect
// 5. Reactive auth with refreshListenable
// 6. ShellRoute for persistent bottom navigation
// 7. context.go() vs context.push() vs context.pop()
// ============================================================

// ============================================================
// PART 1: Auth Service with ChangeNotifier (for reactive guards)
// ============================================================
class AuthService extends ChangeNotifier {
  static bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;
  
  void login() {
    _isLoggedIn = true;
    notifyListeners(); // Triggers redirect re-evaluation
  }
  
  void logout() {
    _isLoggedIn = false;
    notifyListeners(); // Triggers redirect re-evaluation
  }
}

// ============================================================
// PART 2: Screen Widgets
// ============================================================

// ----- Login Screen (Public) -----
class GoRouterLoginScreen extends StatelessWidget {
  const GoRouterLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 40),
              const Text(
                'Welcome to go_router Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'This demonstrates Route Guards with redirect',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Text(
                      '🔒 Route Guard Active',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You cannot access Home, Products, or Search until you log in!\n\n'
                      'Try typing these URLs directly:\n'
                      '• /product/42\n'
                      '• /search?q=test\n'
                      'The redirect guard will send you here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    authService.login();
                    context.go('/'); // Using go() replaces stack
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----- Home Screen (Protected) -----
class GoRouterHomeScreen extends StatelessWidget {
  const GoRouterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter - Home'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              context.go('/login'); // Using go() replaces stack, no back button
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✨ go_router Features Demonstrated ✨',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• URL-based routing: ${Uri.base.toString()}',
                    style: TextStyle(fontSize: 12, color: Colors.deepPurple.shade700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• Path parameters: /product/:id',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• Query parameters: /search?q=',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• Route guards (redirect)',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• context.go() vs context.push() vs context.pop()',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• ShellRoute with persistent bottom nav',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Products Section (Path Parameters Demo)
            const Text(
              '📦 Products (Path Parameters Demo)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap a product - URL becomes /product/:id',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final productId = (index + 1).toString();
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text(productId),
                      ),
                      title: Text('Product $productId'),
                      subtitle: const Text('Tap to see path parameter in action'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Using push() so back button returns to this list
                        context.push('/product/$productId');
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Navigation Examples Section
            const Text(
              '🧭 Navigation Method Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // context.go() example
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/search'),
                    icon: const Icon(Icons.search),
                    label: const Text('go()'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // context.push() example
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/search?q=flutter'),
                    icon: const Icon(Icons.add),
                    label: const Text('push()'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade300,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.info_outline, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'go() replaces stack (no back button) | push() adds to stack (back works)',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----- Product Detail Screen (Path Parameters) -----
class ProductDetailScreen extends StatelessWidget {
  final String productId;
  
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $productId'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Product #$productId',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Path Parameter Demo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '/product/$productId',
                    style: TextStyle(color: Colors.deepPurple.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('← pop() (Back)'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('go() (Replace) →'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----- Search Screen (Query Parameters) -----
class SearchScreen extends StatelessWidget {
  final String? query;
  
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              query != null && query!.isNotEmpty
                  ? 'Showing results for: "$query"'
                  : 'No search query provided',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Query Parameter Demo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    query != null ? '/search?q=$query' : '/search',
                    style: TextStyle(color: Colors.deepPurple.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('← pop() (Back)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ----- Settings Screen (Simple Route) -----
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Settings Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('This demonstrates a simple route without parameters'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('← pop() (Back)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PART 3: Shell Widget for Persistent Bottom Navigation
// ============================================================
class Concept7Shell extends StatelessWidget {
  final Widget child;
  
  const Concept7Shell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // The active route renders here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/'); // Using go() replaces stack
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
  
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/' || location.startsWith('/product')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }
}

// ============================================================
// PART 4: Main App with GoRouter Configuration
// ============================================================
class Concept7App extends StatefulWidget {
  const Concept7App({super.key});

  @override
  State<Concept7App> createState() => _Concept7AppState();
}

class _Concept7AppState extends State<Concept7App> {
  late final AuthService _authService;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _router = _createRouter();
  }

  GoRouter _createRouter() {
    return GoRouter(
      // Initial location - where the app starts
      initialLocation: '/login',
      
      // Reactive guard - listens to auth changes
      refreshListenable: _authService,
      
      // Route Guard - redirect based on authentication state
      // This runs BEFORE every navigation
      redirect: (context, state) {
        final isLoggedIn = _authService.isLoggedIn;
        final isGoingToLogin = state.matchedLocation == '/login';
        
        // Debug output (visible in console)
        debugPrint('🔐 Redirect check - Logged in: $isLoggedIn, Going to: ${state.matchedLocation}');
        
        // Rule 1: Not logged in AND not going to login page -> redirect to login
        if (!isLoggedIn && !isGoingToLogin) {
          debugPrint('↩️ Redirecting to /login (not authenticated)');
          return '/login';
        }
        
        // Rule 2: Already logged in BUT trying to go to login page -> redirect to home
        if (isLoggedIn && isGoingToLogin) {
          debugPrint('🏠 Redirecting to / (already logged in)');
          return '/';
        }
        
        // Rule 3: No redirect needed - allow navigation
        debugPrint('✅ Allowing navigation to: ${state.matchedLocation}');
        return null;
      },
      
      routes: [
        // Public route (no guard needed - redirect handles it)
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const GoRouterLoginScreen(),
        ),
        
        // Protected routes wrapped in ShellRoute for persistent bottom navigation
        ShellRoute(
          builder: (context, state, child) {
            return Concept7Shell(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const GoRouterHomeScreen(),
              routes: [
                // Nested route - demonstrates path parameters
                GoRoute(
                  path: 'product/:id',
                  name: 'product',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return ProductDetailScreen(productId: id);
                  },
                ),
              ],
            ),
            // Search route - demonstrates query parameters
            GoRoute(
              path: '/search',
              name: 'search',
              builder: (context, state) {
                final query = state.uri.queryParameters['q'];
                return SearchScreen(query: query);
              },
            ),
            // Settings route - simple route
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
      
      // Error handler for unknown routes (404)
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('404 - Page Not Found'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text(
                'Page not found: ${state.uri}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Try going to: /, /search, /settings, or /product/1',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _router.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Concept 7: go_router - Declarative Routing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      routerConfig: _router, // Key difference from MaterialApp()
    );
  }
}
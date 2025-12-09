<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<<<<<< HEAD
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Dashboard - Supervision GEID</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* STYLES CORRIGÉS - RESPONSIVE */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            width: 100%;
            flex: 1;
        }

        /* Header Dashboard */
        .dashboard-header-modern {
            background: linear-gradient(135deg, #006747 0%, #8DC63F 100%);
            color: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0, 103, 71, 0.2);
=======
    <title>🏦 Dashboard - Supervision GEID</title>

    <!-- CSS Commun (header/footer) -->
    <link rel="stylesheet" href="css/common.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- CSS Spécifique Dashboard -->
    <style>
        /* ========== STYLES SPÉCIFIQUES DASHBOARD ========== */

        /* Container principal dashboard */
        .dashboard-container {
            padding: 1rem;
        }

        /* Header du dashboard */
        .dashboard-header-modern {
            background: linear-gradient(135deg, rgba(0, 103, 71, 0.1), rgba(141, 198, 63, 0.1));
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 2px solid rgba(0, 103, 71, 0.2);
            box-shadow: 0 10px 30px rgba(0, 103, 71, 0.1);
        }

        .dashboard-header-content {
            max-width: 1200px;
            margin: 0 auto;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .dashboard-title {
            display: flex;
            align-items: center;
<<<<<<< HEAD
            justify-content: space-between;
            margin-bottom: 10px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .dashboard-title h1 {
            font-size: 24px;
            font-weight: 800;
        }

        .dashboard-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 13px;
        }

        .dashboard-subtitle {
            opacity: 0.9;
            margin-bottom: 20px;
            font-size: 15px;
        }

        /* Header Stats */
        .header-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .header-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .header-stats {
                grid-template-columns: 1fr;
            }
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.15);
            padding: 18px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            opacity: 0.8;
        }

        /* System Status */
        .system-status-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
=======
            gap: 1rem;
            margin-bottom: 0.5rem;
        }

        .dashboard-title h1 {
            color: #006747;
            font-size: 2.2rem;
            font-weight: 800;
            margin: 0;
        }

        .dashboard-badge {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
        }

        .dashboard-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .header-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .stat-item {
            background: white;
            padding: 1.2rem;
            border-radius: 16px;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 103, 71, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 103, 71, 0.15);
        }

        .stat-icon {
            font-size: 2rem;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, rgba(0, 103, 71, 0.1), rgba(141, 198, 63, 0.1));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #006747;
            line-height: 1;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }

        /* État du système */
        .system-status-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .system-status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
<<<<<<< HEAD
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f3f4;
            flex-wrap: wrap;
            gap: 15px;
=======
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f8f9fa;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .system-status-header h3 {
            color: #006747;
<<<<<<< HEAD
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
=======
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .system-status-grid {
            display: grid;
<<<<<<< HEAD
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
        }

        @media (max-width: 1024px) {
            .system-status-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .system-status-grid {
                grid-template-columns: 1fr;
            }
        }

        .system-status-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
=======
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .system-status-item {
            padding: 1rem;
            border-radius: 12px;
            background: #f8f9fa;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .system-status-label {
<<<<<<< HEAD
            color: #666;
            font-weight: 600;
            font-size: 14px;
=======
            color: #6c757d;
            font-weight: 600;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .system-status-value {
            font-weight: 700;
<<<<<<< HEAD
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
        }

        .system-status-value.success {
            background: #d4edda;
            color: #155724;
        }

        .system-status-value.warning {
            background: #fff3cd;
            color: #856404;
        }

        .system-status-value.error {
            background: #f8d7da;
            color: #721c24;
        }

        /* Countdown */
        .countdown-timer {
            font-family: monospace;
            background: #f8f9fa;
            padding: 4px 10px;
            border-radius: 4px;
            font-weight: 700;
            color: #006747;
            font-size: 14px;
        }

        /* Servers Section */
        .servers-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .servers-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 20px 0;
        }

        @media (max-width: 1024px) {
            .servers-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .servers-grid {
                grid-template-columns: 1fr;
            }
        }

        .server-card {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-left: 4px solid #006747;
        }

        .server-status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .server-status.online {
            background: #28a745;
        }

        .server-status.offline {
            background: #dc3545;
        }

        .server-status.warning {
            background: #ffc107;
        }

        .server-name {
            font-weight: 700;
            color: #006747;
            font-size: 15px;
        }

        .server-type {
            font-size: 13px;
            color: #666;
        }

        /* Alerts Section */
        .alerts-section-modern {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
=======
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .system-status-value.success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .system-status-value.error {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .system-status-value.warning {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        /* Alertes */
        .alerts-section-modern {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .alerts-header-modern {
            display: flex;
            justify-content: space-between;
            align-items: center;
<<<<<<< HEAD
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
=======
            margin-bottom: 1.5rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .alerts-title {
            display: flex;
            align-items: center;
<<<<<<< HEAD
            gap: 10px;
            font-size: 18px;
=======
            gap: 0.5rem;
            font-size: 1.4rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            font-weight: 700;
            color: #006747;
        }

        .badge-tests {
<<<<<<< HEAD
            background: #dc3545;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
=======
            background: linear-gradient(135deg, #d50032, #ff5252);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            font-weight: 700;
        }

        .alerts-count {
            display: flex;
            align-items: center;
<<<<<<< HEAD
            gap: 10px;
            color: #666;
            font-size: 14px;
=======
            gap: 0.5rem;
            color: #6c757d;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .alert-count-critical {
            color: #d50032;
            font-weight: 700;
        }

        .alert-count-warning {
            color: #ffc107;
            font-weight: 700;
        }

        .alerts-refresh-btn {
            background: #006747;
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
<<<<<<< HEAD
            border: none;
            font-size: 14px;
        }

        /* Stats Cards */
        .stats-section-modern {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .stats-section-modern {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .stats-section-modern {
                grid-template-columns: 1fr;
            }
=======
            transition: all 0.3s ease;
            font-weight: 700;
        }

        .alerts-refresh-btn:hover {
            background: #005738;
            transform: rotate(180deg);
        }

        /* Cartes de statistiques */
        .stats-section-modern {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .stat-card-modern {
            background: white;
<<<<<<< HEAD
            border-radius: 12px;
            padding: 18px;
            border-top: 4px solid #006747;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
=======
            border-radius: 16px;
            padding: 1.5rem;
            border-top: 4px solid;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }

        .stat-card-modern:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 103, 71, 0.15);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
<<<<<<< HEAD
            margin-bottom: 12px;
        }

        .stat-card-icon {
            font-size: 22px;
            color: #006747;
        }

        .stat-card-trend {
            font-size: 12px;
            font-weight: 700;
            padding: 4px 8px;
=======
            margin-bottom: 1rem;
        }

        .stat-card-icon {
            font-size: 2rem;
        }

        .stat-card-trend {
            font-size: 0.8rem;
            font-weight: 700;
            padding: 0.3rem 0.6rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            border-radius: 20px;
        }

        .stat-card-trend.up {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .stat-card-trend.down {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .stat-card-value {
<<<<<<< HEAD
            font-size: 28px;
            font-weight: 800;
            color: #006747;
            line-height: 1;
            margin: 8px 0;
        }

        .stat-card-label {
            color: #666;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .stat-card-progress {
            height: 6px;
=======
            font-size: 2.2rem;
            font-weight: 800;
            color: #006747;
            line-height: 1;
            margin: 0.5rem 0;
        }

        .stat-card-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .stat-card-progress {
            height: 8px;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            background: #f8f9fa;
            border-radius: 4px;
            overflow: hidden;
        }

        .stat-card-progress-bar {
            height: 100%;
            border-radius: 4px;
<<<<<<< HEAD
        }

        /* Quick Actions */
        .quick-actions-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
=======
            transition: width 1s ease;
        }

        /* Actions rapides */
        .quick-actions-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .quick-actions-grid {
            display: grid;
<<<<<<< HEAD
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .quick-actions-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .quick-actions-grid {
                grid-template-columns: 1fr;
            }
=======
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .quick-action-card {
            background: #f8f9fa;
<<<<<<< HEAD
            border-radius: 12px;
            padding: 18px;
        }

        .quick-action-icon {
            font-size: 28px;
            color: #006747;
            margin-bottom: 12px;
        }

        .quick-action-title {
            font-size: 16px;
            font-weight: 700;
            color: #006747;
            margin-bottom: 8px;
        }

        .quick-action-description {
            color: #666;
            font-size: 13px;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        /* Buttons */
        .btn-quick-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #006747;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            font-size: 13px;
            transition: background 0.2s;
        }

        .btn-quick-action:hover {
            background: #005738;
        }

        /* Charts */
        .charts-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
=======
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .quick-action-card:hover {
            border-color: #006747;
            background: white;
            transform: translateY(-5px);
        }

        .quick-action-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .quick-action-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #006747;
            margin-bottom: 0.5rem;
        }

        .quick-action-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .btn-quick-action {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .btn-quick-action:hover {
            background: linear-gradient(135deg, #005738, #7CB839);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 103, 71, 0.3);
            color: white;
            text-decoration: none;
        }

        /* Graphiques */
        .charts-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .charts-grid {
            display: grid;
<<<<<<< HEAD
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
=======
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chart-card {
            background: #f8f9fa;
<<<<<<< HEAD
            border-radius: 12px;
            padding: 18px;
=======
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .chart-card:hover {
            border-color: #006747;
            background: white;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
<<<<<<< HEAD
            margin-bottom: 15px;
=======
            margin-bottom: 1rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chart-header h4 {
            color: #006747;
<<<<<<< HEAD
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
=======
            font-size: 1.1rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chart-badge {
            background: #006747;
            color: white;
<<<<<<< HEAD
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
=======
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            font-weight: 700;
        }

        .chart-container {
<<<<<<< HEAD
            height: 220px;
=======
            height: 250px;
            position: relative;
        }

        /* Compte à rebours */
        .countdown-timer {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 0.2rem 0.5rem;
            border-radius: 6px;
            font-weight: 700;
            color: #006747;
        }

        .refresh-dashboard-btn {
            cursor: pointer;
            color: #006747;
            font-weight: 600;
        }

        .refresh-dashboard-btn:hover {
            text-decoration: underline;
        }

        /* Serveurs actifs */
        .servers-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .servers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .server-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .server-card:hover {
            background: white;
            border-color: #006747;
            transform: translateY(-3px);
        }

        .server-status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .server-status.online {
            background: #28a745;
            box-shadow: 0 0 10px rgba(40, 167, 69, 0.5);
        }

        .server-status.offline {
            background: #dc3545;
            box-shadow: 0 0 10px rgba(220, 53, 69, 0.5);
        }

        .server-status.warning {
            background: #ffc107;
            box-shadow: 0 0 10px rgba(255, 193, 7, 0.5);
        }

        .server-name {
            font-weight: 700;
            color: #006747;
        }

        .server-type {
            font-size: 0.8rem;
            color: #6c757d;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        /* Chatbot */
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .chatbot-button {
<<<<<<< HEAD
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: #006747;
            color: white;
            border: none;
            font-size: 22px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0, 103, 71, 0.3);
            position: relative;
=======
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(0, 103, 71, 0.3);
            transition: all 0.3s ease;
        }

        .chatbot-button:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 25px rgba(0, 103, 71, 0.4);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chatbot-window {
            position: absolute;
<<<<<<< HEAD
            bottom: 65px;
            right: 0;
            width: 320px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            height: 420px;
            border: 2px solid #006747;
        }

        .chatbot-header {
            background: #006747;
            color: white;
            padding: 15px;
            border-radius: 14px 14px 0 0;
=======
            bottom: 70px;
            right: 0;
            width: 350px;
            height: 500px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            overflow: hidden;
        }

        .chatbot-header {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            padding: 1rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-messages {
            flex: 1;
<<<<<<< HEAD
            padding: 15px;
=======
            padding: 1rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            overflow-y: auto;
            background: #f8f9fa;
        }

        .chatbot-input {
<<<<<<< HEAD
            padding: 15px;
            background: white;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 10px;
=======
            padding: 1rem;
            background: white;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 0.5rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chatbot-input input {
            flex: 1;
<<<<<<< HEAD
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            font-size: 14px;
=======
            padding: 0.75rem;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            font-size: 0.9rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .chatbot-input button {
            background: #006747;
            color: white;
            border: none;
<<<<<<< HEAD
            padding: 10px 15px;
            border-radius: 8px;
=======
            padding: 0.75rem 1rem;
            border-radius: 10px;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            cursor: pointer;
        }

        .message {
<<<<<<< HEAD
            margin-bottom: 12px;
        }

        .message.bot {
            text-align: left;
        }

        .message.user {
            text-align: right;
        }

        .message-content {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 15px;
            max-width: 85%;
            font-size: 14px;
=======
            margin-bottom: 1rem;
            max-width: 80%;
        }

        .message.bot {
            align-self: flex-start;
        }

        .message.user {
            align-self: flex-end;
            margin-left: auto;
        }

        .message-content {
            padding: 0.75rem;
            border-radius: 15px;
            font-size: 0.9rem;
            line-height: 1.4;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        }

        .message.bot .message-content {
            background: white;
            border: 1px solid #dee2e6;
        }

        .message.user .message-content {
<<<<<<< HEAD
            background: #006747;
            color: white;
        }

        .chatbot-quick-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 12px 0;
        }

        .chatbot-quick-btn {
            background: #e9ecef;
            border: none;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
        }

        .alert-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Custom Popup ISO Style */
        .popup-iso {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }

        .popup-content {
            background: white;
            border-radius: 12px;
            padding: 25px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: 2px solid #006747;
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f3f4;
        }

        .popup-header h3 {
            color: #006747;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .popup-close {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: #666;
        }

        .popup-body {
            margin-bottom: 20px;
        }

        .popup-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* Notification fix */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 9998;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease;
        }

        .notification.success {
            background: #28a745;
            color: white;
        }

        .notification.error {
            background: #dc3545;
            color: white;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Responsive fixes */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .dashboard-header-modern {
                padding: 20px;
            }

            .dashboard-title h1 {
                font-size: 22px;
=======
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
        }

        /* Animation spinner */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .spinner {
            animation: spin 1s linear infinite;
            display: inline-block;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-stats,
            .system-status-grid,
            .stats-section-modern,
            .quick-actions-grid,
            .charts-grid,
            .servers-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-header-modern {
                padding: 1.5rem;
            }

            .dashboard-title h1 {
                font-size: 1.8rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            }

            .system-status-header {
                flex-direction: column;
<<<<<<< HEAD
                align-items: flex-start;
            }

            .alerts-header-modern {
                flex-direction: column;
=======
                gap: 1rem;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                align-items: flex-start;
            }

            .chatbot-window {
<<<<<<< HEAD
                width: calc(100vw - 30px);
                right: 5px;
                height: 380px;
            }

            .popup-content {
                width: 95%;
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .stat-value {
                font-size: 20px;
            }

            .stat-card-value {
                font-size: 24px;
            }

            .btn-quick-action {
                padding: 8px 16px;
                font-size: 12px;
=======
                width: calc(100vw - 40px);
                height: 400px;
                right: -10px;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            }
        }
    </style>
</head>
<body>
<<<<<<< HEAD
    <!-- Header -->
=======
    <!-- Inclure le header -->
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
    <jsp:include page="includes/header.jsp" />

    <!-- Main Content -->
    <main class="container">
<<<<<<< HEAD
        <!-- Dashboard Header -->
        <header class="dashboard-header-modern">
            <div class="dashboard-title">
                <h1><i class="fas fa-tachometer-alt"></i> Tableau de Bord</h1>
                <span class="dashboard-badge" id="statutGlobal">STABLE</span>
            </div>

            <p class="dashboard-subtitle">
                Vue d'ensemble de l'infrastructure et supervision en temps réel
                <br>
                <small>Dernière mise à jour: <span id="last-update-display">--:--:--</span></small>
            </p>

            <div class="header-stats">
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-server"></i></div>
                    <div>
                        <div class="stat-value" id="serveursActifs">8/12</div>
                        <div class="stat-label">Serveurs actifs</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                    <div>
                        <div class="stat-value" id="disponibilite">98.7%</div>
                        <div class="stat-label">Disponibilité</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-bell"></i></div>
                    <div>
                        <div class="stat-value" id="alertesCritiques">3</div>
                        <div class="stat-label">Alertes critiques</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-sync-alt"></i></div>
                    <div>
                        <div class="stat-value">
                            <span id="last-update-time">--:--:--</span>
                        </div>
                        <div class="stat-label">Dernière mise à jour</div>
                    </div>
                </div>
            </div>
        </header>

        <!-- System Status -->
        <section class="system-status-section">
            <div class="system-status-header">
                <h3><i class="fas fa-chart-line"></i> État du Système</h3>
                <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                    <div style="font-size: 14px; color: #6c757d;">
                        <span id="current-time">--:--:--</span>
                    </div>
                    <div style="font-size: 14px; color: #006747; font-weight: 600; display: flex; align-items: center; gap: 8px;">
                        <i class="fas fa-sync-alt"></i> Rafraîchissement dans
                        <span id="refresh-countdown-header" class="countdown-timer">5:00</span>
                    </div>
                </div>
            </div>

            <div class="system-status-grid">
                <div class="system-status-item">
                    <span class="system-status-label">Statut global</span>
                    <span class="system-status-value success" id="statutGlobalValue">STABLE</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Prochaine MAJ</span>
                    <span class="system-status-value warning" id="prochaineMAJ">--/-- --:--</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Disponibilité</span>
                    <span class="system-status-value" id="disponibiliteValue">98.7%</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Alertes critiques</span>
                    <span class="system-status-value error" id="alertesCritiquesValue">3</span>
                </div>
            </div>
        </section>

        <!-- Active Servers -->
        <section class="servers-section">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h3 style="color: #006747; font-size: 18px; display: flex; align-items: center; gap: 10px;">
                    <i class="fas fa-server"></i> Serveurs Actifs
                </h3>
                <a href="/serveurs" style="font-size: 14px; text-decoration: none; color: #006747; font-weight: 600;">
                    Voir tous <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="servers-grid" id="serveursGrid">
                <!-- Filled by JavaScript -->
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <a href="/serveurs" class="btn-quick-action">
                    <i class="fas fa-list"></i> Voir tous les serveurs
                </a>
            </div>
        </section>

        <!-- Alerts -->
        <section class="alerts-section-modern">
            <div class="alerts-header-modern">
                <div class="alerts-title">
                    <i class="fas fa-bell"></i> Alertes Actives
                    <span class="badge-tests" id="alertesBadge">3 CRITIQUES</span>
                </div>

                <div class="alerts-count">
                    <span class="alert-count-critical" id="alertesCritiquesCount">3 critiques</span>
                    <span class="alert-count-warning" id="alertesWarningCount">/ 2 warnings</span>
                    <button class="alerts-refresh-btn" onclick="rafraichirAlertes()">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </div>
            </div>

            <div id="alertesContainer">
                <!-- Filled by JavaScript -->
            </div>
        </section>

        <!-- Stats Cards -->
        <section class="stats-section-modern">
            <div class="stat-card-modern" style="border-top-color: #006747;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="stat-card-trend up">+2.5%</div>
                </div>
                <div class="stat-card-value" id="statsDisponibilite">98.7%</div>
                <div class="stat-card-label">Taux de disponibilité mensuel</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressDisponibilite" style="width: 98.7%; background: #006747;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #28a745;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-check-circle"></i></div>
                    <div class="stat-card-trend up">+8%</div>
                </div>
                <div class="stat-card-value" id="statsTestsReussis">96.2%</div>
                <div class="stat-card-label">Tests réussis (24h)</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressTests" style="width: 96.2%; background: #28a745;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #ffc107;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-bolt"></i></div>
                    <div class="stat-card-trend down">-15ms</div>
                </div>
                <div class="stat-card-value" id="statsTempsReponse">124ms</div>
                <div class="stat-card-label">Temps de réponse moyen</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressTemps" style="width: 85%; background: #ffc107;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #17a2b8;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-wrench"></i></div>
                    <div class="stat-card-trend up">+12</div>
                </div>
                <div class="stat-card-value" id="statsIncidentsResolus">142</div>
                <div class="stat-card-label">Incidents résolus (7j)</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressIncidents" style="width: 92%; background: #17a2b8;"></div>
                </div>
            </div>
        </section>

        <!-- Quick Actions -->
        <section class="quick-actions-section">
            <h3 style="color: #006747; font-size: 18px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                <i class="fas fa-bolt"></i> Actions Rapides
            </h3>

            <div class="quick-actions-grid">
                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-play-circle"></i></div>
                    <div class="quick-action-title">Lancer Tous les Tests</div>
                    <div class="quick-action-description">Exécute tous les tests actifs sur l'ensemble des serveurs</div>
                    <button class="btn-quick-action" onclick="lancerTousTestsPopup()">
                        <i class="fas fa-play"></i> Exécuter
                    </button>
                </div>

                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-filter"></i></div>
                    <div class="quick-action-title">Tests par Catégorie</div>
                    <div class="quick-action-description">Exécute des tests ciblés par catégorie</div>
                    <select id="categorieSelectDashboard" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 15px; font-size: 14px;">
                        <option value="">Choisir une catégorie</option>
                        <option value="conformite">Conformité</option>
                        <option value="processus_metier">Processus Métier</option>
                        <option value="surveillance">Surveillance</option>
                        <option value="ged">GED</option>
                        <option value="integration">Intégration</option>
                        <option value="web">Applications Web</option>
                    </select>
                    <button class="btn-quick-action" onclick="dashboardLancerTestsCategoriePopup()">
                        <i class="fas fa-play"></i> Lancer
                    </button>
                </div>

                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-calendar-plus"></i></div>
                    <div class="quick-action-title">Planifier une MAJ</div>
                    <div class="quick-action-description">Programmer une mise à jour de l'infrastructure</div>
                    <a href="/mises-a-jour/create" class="btn-quick-action">
                        <i class="fas fa-plus"></i> Nouvelle MAJ
                    </a>
                </div>
            </div>
        </section>

        <!-- Charts -->
        <section class="charts-section">
            <h3 style="color: #006747; font-size: 18px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                <i class="fas fa-chart-line"></i> Métriques en Temps Réel
            </h3>

            <div class="charts-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-microchip"></i> Utilisation CPU</h4>
                        <span class="chart-badge">EN TEMPS RÉEL</span>
                    </div>
                    <div class="chart-container">
                        <canvas id="cpuChart"></canvas>
                    </div>
                </div>

                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-memory"></i> Utilisation Mémoire</h4>
                        <span class="chart-badge">24H</span>
                    </div>
                    <div class="chart-container">
                        <canvas id="memoryChart"></canvas>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Popup ISO Style -->
    <div class="popup-iso" id="popupIso">
        <div class="popup-content">
            <div class="popup-header">
                <h3><i class="fas fa-info-circle"></i> <span id="popupTitle"></span></h3>
                <button class="popup-close" onclick="closePopup()">&times;</button>
            </div>
            <div class="popup-body" id="popupBody">
                <!-- Content will be inserted here -->
            </div>
            <div class="popup-footer">
                <button class="btn-quick-action" onclick="closePopup()">Fermer</button>
            </div>
        </div>
    </div>

    <!-- Chatbot -->
    <div class="chatbot-container">
        <div class="chatbot-window" id="chatbotWindow">
            <div class="chatbot-header">
                <strong><i class="fas fa-robot"></i> Assistant GEID</strong>
                <button onclick="toggleChatbot()" style="background: none; border: none; color: white; cursor: pointer;">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot">
                    <div class="message-content">
                        Bonjour ! Je suis l'assistant GEID. Comment puis-je vous aider avec le tableau de bord ?
                    </div>
                </div>
            </div>
            <div class="chatbot-input">
                <input type="text" id="chatbotInput" placeholder="Posez votre question...">
                <button onclick="sendChatbotMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
        <button class="chatbot-button" onclick="toggleChatbot()">
            <i class="fas fa-robot"></i>
            <span class="alert-badge" id="chatbotAlertBadge">3</span>
        </button>
    </div>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- JavaScript CORRIGÉ -->
    <script>
        // Données d'exemple
        var dashboardData = {
            serveurs: [
                { id: 1, nom: "SRV-PROD-01", type: "Production", statut: "ONLINE", chargeCPU: 45 },
                { id: 2, nom: "SRV-PROD-02", type: "Production", statut: "ONLINE", chargeCPU: 32 },
                { id: 3, nom: "SRV-TEST-01", type: "Test", statut: "ONLINE", chargeCPU: 28 },
                { id: 4, nom: "SRV-DB-01", type: "Base de données", statut: "WARNING", chargeCPU: 78 },
                { id: 5, nom: "SRV-WEB-01", type: "Web", statut: "ONLINE", chargeCPU: 22 },
                { id: 6, nom: "SRV-BACKUP-01", type: "Backup", statut: "OFFLINE", chargeCPU: 0 }
            ],
            alertes: [
                { id: 1, nom: "CPU élevé", description: "Utilisation CPU > 80%", serveurCible: "SRV-DB-01", criticite: "CRITICAL", date: "15/12 10:30" },
                { id: 2, nom: "Mémoire insuffisante", description: "Mémoire disponible < 10%", serveurCible: "SRV-PROD-01", criticite: "WARNING", date: "15/12 09:45" },
                { id: 3, nom: "Service arrêté", description: "Service Apache arrêté", serveurCible: "SRV-WEB-01", criticite: "CRITICAL", date: "15/12 08:15" },
                { id: 4, nom: "Disque plein", description: "Espace disque < 5%", serveurCible: "SRV-BACKUP-01", criticite: "CRITICAL", date: "14/12 22:30" },
                { id: 5, nom: "Latence réseau", description: "Latence > 200ms", criticite: "WARNING", date: "14/12 21:00" }
            ],
            stats: {
                serveursActifs: "8/12",
                disponibilite: "98.7%",
                alertesCritiques: 3,
                alertesWarning: 2,
                statutGlobal: "STABLE",
                tauxDisponibilite: 98.7,
                testsReussis: 96.2,
                tempsReponse: 124,
                incidentsResolus: 142
            }
        };

        // Variables globales
        var countdownInterval;
        var timeLeft = 5 * 60;
        var cpuChart = null;
        var memoryChart = null;
        var currentNotification = null;

        // Initialisation au chargement
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Dashboard initialisé');

            initDashboardData();
            startCountdown();
            updateClock();
            setInterval(updateClock, 1000);
            initCharts();
            updateProchaineMAJ();
            initChatbot();
            setupProgressBars();
        });

        // Initialiser les données
        function initDashboardData() {
            // Mettre à jour les stats
            document.getElementById('serveursActifs').textContent = dashboardData.stats.serveursActifs;
            document.getElementById('disponibilite').textContent = dashboardData.stats.disponibilite;
            document.getElementById('alertesCritiques').textContent = dashboardData.stats.alertesCritiques;
            document.getElementById('statutGlobal').textContent = dashboardData.stats.statutGlobal;
            document.getElementById('statutGlobalValue').textContent = dashboardData.stats.statutGlobal;
            document.getElementById('disponibiliteValue').textContent = dashboardData.stats.disponibilite;
            document.getElementById('alertesCritiquesValue').textContent = dashboardData.stats.alertesCritiques;

            // Mettre à jour les cartes de stats
            document.getElementById('statsDisponibilite').textContent = dashboardData.stats.disponibilite;
            document.getElementById('statsTestsReussis').textContent = dashboardData.stats.testsReussis + '%';
            document.getElementById('statsTempsReponse').textContent = dashboardData.stats.tempsReponse + 'ms';
            document.getElementById('statsIncidentsResolus').textContent = dashboardData.stats.incidentsResolus;

            // Afficher les serveurs
            displayServeurs();

            // Afficher les alertes
            displayAlertes();

            // Mettre à jour la dernière MAJ
            updateLastUpdate();

            // Mettre à jour le badge du chatbot
            updateChatbotBadge();
        }

        // Afficher les serveurs
        function displayServeurs() {
            var grid = document.getElementById('serveursGrid');
            grid.innerHTML = '';

            dashboardData.serveurs.forEach(function(serveur) {
                var statusClass = serveur.statut === 'ONLINE' ? 'online' :
                                serveur.statut === 'OFFLINE' ? 'offline' : 'warning';

                var card = document.createElement('div');
                card.className = 'server-card';
                card.innerHTML = '<div class="server-status ' + statusClass + '"></div>' +
                               '<div style="flex: 1;">' +
                               '<div class="server-name">' + serveur.nom + '</div>' +
                               '<div class="server-type">' + serveur.type + '</div>' +
                               '</div>' +
                               '<div style="font-size: 13px; color: #666;">CPU: ' + serveur.chargeCPU + '%</div>';
                grid.appendChild(card);
            });
        }

        // Afficher les alertes
        function displayAlertes() {
            var container = document.getElementById('alertesContainer');
            var alertesCritiques = dashboardData.alertes.filter(function(a) { return a.criticite === 'CRITICAL'; }).length;
            var alertesWarning = dashboardData.alertes.filter(function(a) { return a.criticite === 'WARNING'; }).length;

            // Mettre à jour les compteurs
            document.getElementById('alertesBadge').textContent = alertesCritiques + ' CRITIQUES';
            document.getElementById('alertesCritiquesCount').textContent = alertesCritiques + ' critiques';
            document.getElementById('alertesWarningCount').textContent = '/ ' + alertesWarning + ' warnings';

            if (dashboardData.alertes.length > 0) {
                var html = '<div style="overflow-x: auto;">' +
                          '<table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px;">' +
                          '<thead style="background: #f8f9fa;">' +
                          '<tr>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Type</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Description</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Serveur</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Date</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Statut</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Actions</th>' +
                          '</tr>' +
                          '</thead>' +
                          '<tbody>';

                dashboardData.alertes.forEach(function(alerte) {
                    var color, icon, bgColor, statutText;

                    if (alerte.criticite === 'CRITICAL') {
                        color = '#d50032';
                        icon = 'fa-exclamation-circle';
                        bgColor = '#d50032';
                        statutText = 'Critique';
                    } else if (alerte.criticite === 'WARNING') {
                        color = '#ffc107';
                        icon = 'fa-exclamation-triangle';
                        bgColor = '#ffc107';
                        statutText = 'Alerte';
                    } else {
                        color = '#2196F3';
                        icon = 'fa-info-circle';
                        bgColor = '#2196F3';
                        statutText = 'Normal';
                    }

                    html += '<tr style="border-bottom: 1px solid #f1f3f4;">' +
                           '<td style="padding: 12px;">' +
                           '<span style="color: ' + color + ';">' +
                           '<i class="fas ' + icon + '"></i>' +
                           '<strong style="font-size: 13px;">' + alerte.criticite + '</strong>' +
                           '</span>' +
                           '</td>' +
                           '<td style="padding: 12px;">' +
                           '<strong style="font-size: 14px;">' + alerte.nom + '</strong>' +
                           '<div style="font-size: 13px; color: #666; margin-top: 4px;">' + alerte.description + '</div>' +
                           '</td>' +
                           '<td style="padding: 12px;">';

                    if (alerte.serveurCible) {
                        html += '<span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 13px;">' + alerte.serveurCible + '</span>';
                    } else {
                        html += '<span style="color: #999; font-size: 13px;">N/A</span>';
                    }

                    html += '</td>' +
                           '<td style="padding: 12px; font-size: 13px;">' + alerte.date + '</td>' +
                           '<td style="padding: 12px;">' +
                           '<span style="background: ' + bgColor + '; color: white; padding: 4px 8px; border-radius: 4px; font-size: 13px;">' + statutText + '</span>' +
                           '</td>' +
                           '<td style="padding: 12px;">' +
                           '<button onclick="voirAlerteDetailPopup(' + alerte.id + ')" style="background: #006747; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 13px;">' +
                           '<i class="fas fa-eye"></i> Voir' +
                           '</button>' +
                           '</td>' +
                           '</tr>';
                });

                html += '</tbody>' +
                       '</table>' +
                       '</div>' +
                       '<div style="margin-top: 20px; text-align: center; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">' +
                       '<a href="/alertes" class="btn-quick-action" style="text-decoration: none;">' +
                       '<i class="fas fa-list"></i> Voir toutes les alertes' +
                       '</a>' +
                       '<button onclick="rafraichirAlertes()" class="btn-quick-action" style="background: #6c757d;">' +
                       '<i class="fas fa-sync-alt"></i> Rafraîchir' +
                       '</button>' +
                       '</div>';

                container.innerHTML = html;
            } else {
                container.innerHTML = '<div style="text-align: center; padding: 40px; background: #f8f9fa; border-radius: 12px;">' +
                                     '<div style="font-size: 48px; margin-bottom: 15px; color: #28a745;">' +
                                     '<i class="fas fa-check-circle"></i>' +
                                     '</div>' +
                                     '<h4 style="color: #006747;">Aucune alerte critique</h4>' +
                                     '<p style="color: #6c757d;">Tous les systèmes fonctionnent normalement</p>' +
                                     '</div>';
            }
        }

        // Configurer les barres de progression
        function setupProgressBars() {
            setTimeout(function() {
                document.getElementById('progressDisponibilite').style.width = '98.7%';
                document.getElementById('progressDisponibilite').style.background = '#006747';

                document.getElementById('progressTests').style.width = '96.2%';
                document.getElementById('progressTests').style.background = '#28a745';

                document.getElementById('progressTemps').style.width = '85%';
                document.getElementById('progressTemps').style.background = '#ffc107';

                document.getElementById('progressIncidents').style.width = '92%';
                document.getElementById('progressIncidents').style.background = '#17a2b8';
            }, 300);
        }

        // Compte à rebours
=======
        <div class="dashboard-container">

            <!-- Header principal -->
            <header class="dashboard-header-modern">
                <div class="dashboard-header-content">
                    <div class="dashboard-title">
                        <h1>Tableau de Bord</h1>
                        <span class="dashboard-badge">
                            <c:choose>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'EXCELLENT'}">
                                    🏆 EXCELLENT
                                </c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'BON'}">
                                    👍 BON
                                </c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'STABLE'}">
                                    ✅ STABLE
                                </c:when>
                                <c:otherwise>
                                    ⚠️ DÉGRADÉ
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <p class="dashboard-subtitle">
                        Vue d'ensemble de l'infrastructure et supervision en temps réel
                        <br>
                        <small>Dernière mise à jour:
                            <span id="last-update-display">
                                <c:choose>
                                    <c:when test="${not empty derniereMaj}">
                                        <c:out value="${derniereMaj}" />
                                    </c:when>
                                    <c:otherwise>
                                        <script>
                                            document.write(new Date().toLocaleString('fr-FR'));
                                        </script>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </small>
                    </p>

                    <div class="header-stats">
                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-server"></i></div>
                            <div>
                                <div class="stat-value" data-stat="serveursActifs">
                                    <c:choose>
                                        <c:when test="${not empty serveursActifs and not empty totalServeurs}">
                                            <c:out value="${serveursActifs}" />/<c:out value="${totalServeurs}" />
                                        </c:when>
                                        <c:otherwise>0/0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Serveurs actifs</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                            <div>
                                <div class="stat-value" data-stat="disponibilite">
                                    <c:choose>
                                        <c:when test="${not empty tauxDisponibilite}">
                                            <c:out value="${tauxDisponibilite}" />%
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Disponibilité</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-bell"></i></div>
                            <div>
                                <div class="stat-value">
                                    <c:choose>
                                        <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                            <c:out value="${statsAlertes.critical}" />
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Alertes critiques</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-sync-alt"></i></div>
                            <div>
                                <div class="stat-value last-update-time">
                                    <c:choose>
                                        <c:when test="${not empty derniereMaj}">
                                            <c:out value="${derniereMaj}" />
                                        </c:when>
                                        <c:otherwise>--:--:--</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Dernière mise à jour</div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- État du système -->
            <section class="system-status-section">
                <div class="system-status-header">
                    <h3><span><i class="fas fa-chart-line"></i></span> État du Système</h3>
                    <div style="display: flex; align-items: center; gap: 1rem;">
                        <div style="font-size: 0.9rem; color: #6c757d;">
                            <span id="current-time">--:--</span>
                        </div>
                        <div style="font-size: 0.9rem; color: #006747; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                            <span><i class="fas fa-sync-alt"></i></span> Rafraîchissement dans
                            <span id="refresh-countdown-header" class="countdown-timer">5:00</span>
                        </div>
                    </div>
                </div>

                <div class="system-status-grid">
                    <div class="system-status-item">
                        <span class="system-status-label">Statut global</span>
                        <span class="system-status-value
                            <c:choose>
                                <c:when test="${not empty performanceIndicators and (performanceIndicators.statutGlobal == 'EXCELLENT' or performanceIndicators.statutGlobal == 'BON')}">success</c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'STABLE'}">success</c:when>
                                <c:otherwise>error</c:otherwise>
                            </c:choose>">
                            <c:choose>
                                <c:when test="${not empty performanceIndicators}">
                                    <c:out value="${performanceIndicators.statutGlobal}" />
                                </c:when>
                                <c:otherwise>CHARGEMENT...</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Prochaine MAJ</span>
                        <span class="system-status-value warning">
                            <c:choose>
                                <c:when test="${not empty prochaineMAJDate}">
                                    <c:out value="${prochaineMAJDate}" />
                                </c:when>
                                <c:otherwise>
                                    <script>
                                        const demain = new Date();
                                        demain.setDate(demain.getDate() + 1);
                                        demain.setHours(2, 0, 0, 0);
                                        const options = { day: '2-digit', month: '2-digit', hour: '2-digit', minute: '2-digit' };
                                        document.write(demain.toLocaleDateString('fr-FR', options).replace(',', ''));
                                    </script>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Disponibilité</span>
                        <span class="system-status-value">
                            <c:choose>
                                <c:when test="${not empty tauxDisponibilite}">
                                    <c:out value="${tauxDisponibilite}" />%
                                </c:when>
                                <c:otherwise>0%</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Alertes critiques</span>
                        <span class="system-status-value error">
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                    <c:out value="${statsAlertes.critical}" />
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </section>

            <!-- Section des serveurs actifs -->
            <section class="servers-section">
                <h3 style="margin-bottom: 1.5rem; color: #006747; display: flex; align-items: center; gap: 0.5rem;">
                    <span><i class="fas fa-server"></i></span> Serveurs Actifs
                    <a href="/serveurs" style="margin-left: auto; font-size: 0.9rem; text-decoration: none; color: #006747; font-weight: 600;">
                        Voir tous <i class="fas fa-arrow-right"></i>
                    </a>
                </h3>

                <div class="servers-grid">
                    <c:choose>
                        <c:when test="${not empty serveurs and !serveurs.isEmpty()}">
                            <c:forEach var="serveur" items="${serveurs}" varStatus="status" end="5">
                                <div class="server-card">
                                    <div class="server-status
                                        <c:choose>
                                            <c:when test="${serveur.statut == 'ONLINE'}">online</c:when>
                                            <c:when test="${serveur.statut == 'OFFLINE'}">offline</c:when>
                                            <c:otherwise>warning</c:otherwise>
                                        </c:choose>">
                                    </div>
                                    <div style="flex: 1;">
                                        <div class="server-name"><c:out value="${serveur.nom}" /></div>
                                        <div class="server-type"><c:out value="${serveur.type}" /></div>
                                    </div>
                                    <div style="font-size: 0.8rem; color: #6c757d;">
                                        <c:choose>
                                            <c:when test="${not empty serveur.chargeCPU}">
                                                CPU: <c:out value="${serveur.chargeCPU}" />%
                                            </c:when>
                                            <c:otherwise>CPU: N/A</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 2rem; color: #6c757d;">
                                <i class="fas fa-server" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
                                <p>Aucun serveur disponible</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty serveurs and serveurs.size() > 6}">
                    <div style="text-align: center; margin-top: 1.5rem;">
                        <a href="/serveurs" class="btn-quick-action" style="text-decoration: none;">
                            <i class="fas fa-list"></i> Voir tous les serveurs (<c:out value="${serveurs.size()}" />)
                        </a>
                    </div>
                </c:if>
            </section>

            <!-- Section des alertes -->
            <section class="alerts-section-modern">
                <div class="alerts-header-modern">
                    <div class="alerts-title">
                        <span><i class="fas fa-bell"></i></span> Alertes Actives
                        <c:if test="${not empty statsAlertes and not empty statsAlertes.critical and statsAlertes.critical > 0}">
                            <span class="badge-tests"><c:out value="${statsAlertes.critical}" /> CRITIQUES</span>
                        </c:if>
                    </div>

                    <div class="alerts-count">
                        <span class="alert-count-critical">
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                    <c:out value="${statsAlertes.critical}" /> critiques
                                </c:when>
                                <c:otherwise>0 critiques</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="alert-count-warning">
                            /
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.warning}">
                                    <c:out value="${statsAlertes.warning}" /> warnings
                                </c:when>
                                <c:otherwise>0 warnings</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="alerts-refresh-btn" title="Rafraîchir les alertes" onclick="rafraichirAlertes()">
                            <i class="fas fa-sync-alt"></i>
                        </span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty alertesCritiques and !alertesCritiques.isEmpty()}">
                        <!-- Tableau des alertes -->
                        <div style="overflow-x: auto;">
                            <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px;">
                                <thead style="background: #f8f9fa;">
                                    <tr>
                                        <th style="padding: 12px; text-align: left;">Type</th>
                                        <th style="padding: 12px; text-align: left;">Description</th>
                                        <th style="padding: 12px; text-align: left;">Serveur</th>
                                        <th style="padding: 12px; text-align: left;">Date</th>
                                        <th style="padding: 12px; text-align: left;">Statut</th>
                                        <th style="padding: 12px; text-align: left;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="alerte" items="${alertesCritiques}" varStatus="status" end="4">
                                        <tr style="border-bottom: 1px solid #f1f3f4;">
                                            <td style="padding: 12px;">
                                                <span style="color:
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}">#d50032</c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}">#ffc107</c:when>
                                                        <c:otherwise>#2196F3</c:otherwise>
                                                    </c:choose>;">
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}"><i class="fas fa-exclamation-circle"></i></c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}"><i class="fas fa-exclamation-triangle"></i></c:when>
                                                        <c:otherwise><i class="fas fa-info-circle"></i></c:otherwise>
                                                    </c:choose>
                                                    <strong><c:out value="${alerte.criticite}" /></strong>
                                                </span>
                                            </td>
                                            <td style="padding: 12px;">
                                                <strong><c:out value="${alerte.nom}" /></strong>
                                                <c:if test="${not empty alerte.description}">
                                                    <div style="font-size: 0.9rem; color: #666; margin-top: 4px;">
                                                        <c:out value="${alerte.description}" />
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td style="padding: 12px;">
                                                <c:if test="${not empty alerte.serveurCible}">
                                                    <span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 0.9rem;">
                                                        <c:out value="${alerte.serveurCible}" />
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td style="padding: 12px;">
                                                <c:choose>
                                                    <c:when test="${not empty alerte.timestampDisplay}">
                                                        <c:out value="${alerte.timestampDisplay}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatDate value="${alerte.dateCreation}" pattern="dd/MM/yyyy HH:mm" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="padding: 12px;">
                                                <span style="background:
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}">#d50032</c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}">#ffc107</c:when>
                                                        <c:otherwise>#2196F3</c:otherwise>
                                                    </c:choose>;
                                                    color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.9rem;">
                                                    <c:choose>
                                                        <c:when test="${not empty alerte.statutCourt}">
                                                            <c:out value="${alerte.statutCourt}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${alerte.criticite == 'CRITICAL'}">Critique</c:when>
                                                                <c:otherwise>Normal</c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td style="padding: 12px;">
                                                <button onclick="voirAlerteDetail('${alerte.id}')" style="background: #006747; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 0.9rem;">
                                                    <i class="fas fa-eye"></i> Voir
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div style="margin-top: 1.5rem; text-align: center; display: flex; gap: 1rem; justify-content: center;">
                            <a href="/alertes" class="btn-quick-action" style="text-decoration: none;">
                                <i class="fas fa-list"></i> Voir toutes les alertes
                            </a>
                            <button onclick="rafraichirAlertes()" class="btn-quick-action" style="background: #6c757d;">
                                <i class="fas fa-sync-alt"></i> Rafraîchir
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 3rem; background: #f8f9fa; border-radius: 12px;">
                            <div style="font-size: 4rem; margin-bottom: 1rem; color: #28a745;">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h4 style="color: #006747;">Aucune alerte critique</h4>
                            <p style="color: #6c757d;">Tous les systèmes fonctionnent normalement</p>
                            <div style="margin-top: 1.5rem;">
                                <a href="/alertes" class="btn-quick-action" style="text-decoration: none;">
                                    <i class="fas fa-history"></i> Voir l'historique
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Cartes de statistiques -->
            <section class="stats-section-modern">
                <!-- Carte 1 : Disponibilité -->
                <div class="stat-card-modern" style="border-top-color: #006747;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-chart-line"></i></div>
                        <div class="stat-card-trend up">+2.5%</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty tauxDisponibilite}">
                                <c:out value="${tauxDisponibilite}" />%
                            </c:when>
                            <c:otherwise>98.7%</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Taux de disponibilité mensuel</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #006747; width:
                            <c:choose>
                                <c:when test="${not empty tauxDisponibilite}">
                                    <c:out value="${tauxDisponibilite}" />%
                                </c:when>
                                <c:otherwise>98.7%</c:otherwise>
                            </c:choose>;"></div>
                    </div>
                </div>

                <!-- Carte 2 : Tests réussis -->
                <div class="stat-card-modern" style="border-top-color: #28a745;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-check-circle"></i></div>
                        <div class="stat-card-trend up">+8%</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty statsTests and not empty statsTests.reussisPourcentage}">
                                <c:out value="${statsTests.reussisPourcentage}" />%
                            </c:when>
                            <c:otherwise>96.2%</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Tests réussis (24h)</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #28a745; width:
                            <c:choose>
                                <c:when test="${not empty statsTests and not empty statsTests.reussisPourcentage}">
                                    <c:out value="${statsTests.reussisPourcentage}" />%
                                </c:when>
                                <c:otherwise>96.2%</c:otherwise>
                            </c:choose>;"></div>
                    </div>
                </div>

                <!-- Carte 3 : Temps réponse moyen -->
                <div class="stat-card-modern" style="border-top-color: #ffc107;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-bolt"></i></div>
                        <div class="stat-card-trend down">-15ms</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty performanceIndicators and not empty performanceIndicators.tempsReponseMoyen}">
                                <c:out value="${performanceIndicators.tempsReponseMoyen}" />ms
                            </c:when>
                            <c:otherwise>124ms</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Temps de réponse moyen</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #ffc107; width: 85%;"></div>
                    </div>
                </div>

                <!-- Carte 4 : Incidents résolus -->
                <div class="stat-card-modern" style="border-top-color: #17a2b8;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-wrench"></i></div>
                        <div class="stat-card-trend up">+12</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty incidentsResolus}">
                                <c:out value="${incidentsResolus}" />
                            </c:when>
                            <c:otherwise>142</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Incidents résolus (7j)</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #17a2b8; width: 92%;"></div>
                    </div>
                </div>
            </section>

            <!-- Actions rapides -->
            <section class="quick-actions-section">
                <h3 style="margin-bottom: 1.5rem; color: #006747; display: flex; align-items: center; gap: 0.5rem;">
                    <span><i class="fas fa-bolt"></i></span> Actions Rapides
                </h3>

                <div class="quick-actions-grid">
                    <!-- Lancer Tous les Tests -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-play-circle"></i></div>
                        <div class="quick-action-title">Lancer Tous les Tests</div>
                        <div class="quick-action-description">Exécute tous les tests actifs sur l'ensemble des serveurs</div>
                        <button type="button" onclick="lancerTousTests()" class="btn-quick-action btn-test-all">
                            <i class="fas fa-play"></i> Exécuter
                        </button>
                    </div>

                    <!-- Tests par Catégorie -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-filter"></i></div>
                        <div class="quick-action-title">Tests par Catégorie</div>
                        <div class="quick-action-description">Exécute des tests ciblés par catégorie</div>
                        <div style="margin-bottom: 1rem;">
                            <select id="categorieSelectDashboard" style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 8px; background: white; font-size: 0.9rem;">
                                <option value="">Choisir une catégorie</option>
                                <option value="conformite">Conformité</option>
                                <option value="processus_metier">Processus Métier</option>
                                <option value="surveillance">Surveillance</option>
                                <option value="ged">GED</option>
                                <option value="integration">Intégration</option>
                                <option value="web">Applications Web</option>
                            </select>
                        </div>
                        <button type="button" onclick="dashboardLancerTestsCategorie()" class="btn-quick-action btn-test-category">
                            <i class="fas fa-play"></i> Lancer
                        </button>
                    </div>

                    <!-- Planifier MAJ -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-calendar-plus"></i></div>
                        <div class="quick-action-title">Planifier une MAJ</div>
                        <div class="quick-action-description">Programmer une mise à jour de l'infrastructure</div>
                        <a href="/mises-a-jour/create" class="btn-quick-action btn-schedule-maj">
                            <i class="fas fa-plus"></i> Nouvelle MAJ
                        </a>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Chatbot -->
    <div class="chatbot-container">
        <div class="chatbot-window" id="chatbotWindow">
            <div class="chatbot-header">
                <div>
                    <strong><i class="fas fa-robot"></i> Assistant GEID</strong>
                    <div style="font-size: 0.8rem; opacity: 0.8;">Vous aide avec le dashboard</div>
                </div>
                <button onclick="toggleChatbot()" style="background: none; border: none; color: white; cursor: pointer;">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot">
                    <div class="message-content">
                        Bonjour ! Je suis l'assistant GEID. Comment puis-je vous aider avec le tableau de bord ?
                    </div>
                </div>
            </div>
            <div class="chatbot-input">
                <input type="text" id="chatbotInput" placeholder="Posez votre question..." onkeypress="handleChatbotKeypress(event)">
                <button onclick="sendChatbotMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
        <button class="chatbot-button" onclick="toggleChatbot()">
            <i class="fas fa-robot"></i>
        </button>
    </div>

    <!-- Inclure le footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Chart.js pour les graphiques -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- JavaScript du dashboard -->
    <script>
        // Variables globales
        let countdownInterval;
        let timeLeft = 5 * 60; // 5 minutes en secondes
        let cpuChart = null;
        let memoryChart = null;

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            console.log('📊 Dashboard initialisé');

            // Démarrer le compte à rebours
            startCountdown();

            // Mettre à jour l'horloge
            updateClock();
            setInterval(updateClock, 60000);

            // Bouton de rafraîchissement manuel
            setupRefreshButtons();

            // Initialiser les graphiques
            initCharts();

            // Animation des cartes de statistiques
            animateStats();

            // Initialiser le chatbot
            initChatbot();
        });

        // ========== COMPTE À REBOURS ==========
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
        function startCountdown() {
            clearInterval(countdownInterval);
            timeLeft = 5 * 60;

            function updateCountdownDisplay() {
<<<<<<< HEAD
                var minutes = Math.floor(timeLeft / 60);
                var seconds = timeLeft % 60;

                var countdownElement = document.getElementById('refresh-countdown-header');
                if (countdownElement) {
                    countdownElement.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
                }

                if (timeLeft <= 0) {
                    timeLeft = 5 * 60;
                    refreshDashboard();
=======
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;

                // Mettre à jour TOUTES les occurrences du compte à rebours
                const countdownElements = document.querySelectorAll('.countdown-timer, #refresh-countdown, #refresh-countdown-header');
                countdownElements.forEach(element => {
                    if (element) {
                        element.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
                    }
                });

                if (timeLeft <= 0) {
                    timeLeft = 5 * 60; // Reset
                    console.log('🔄 Compte à rebours terminé, rafraîchissement automatique');
                    refreshDashboard(); // Rafraîchir automatiquement
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                } else {
                    timeLeft--;
                }
            }

<<<<<<< HEAD
            updateCountdownDisplay();
            countdownInterval = setInterval(updateCountdownDisplay, 1000);
        }

        // Horloge
        function updateClock() {
            var now = new Date();
            var timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            var dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            document.getElementById('current-time').innerHTML = '<strong>' + timeStr + '</strong> - ' + dateStr;
        }

        // Prochaine MAJ dynamique
        function updateProchaineMAJ() {
            var now = new Date();
            var tomorrow = new Date(now);
            tomorrow.setDate(tomorrow.getDate() + 1);
            tomorrow.setHours(2, 0, 0, 0);

            var formattedDate = tomorrow.toLocaleDateString('fr-FR', {
                day: '2-digit',
                month: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            }).replace(',', '');

            document.getElementById('prochaineMAJ').textContent = formattedDate;
        }

        // Dernière mise à jour
        function updateLastUpdate() {
            var now = new Date();
            var timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            var dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            document.getElementById('last-update-display').textContent = timeStr + ' - ' + dateStr;
            document.getElementById('last-update-time').textContent = timeStr;
        }

        // Badge chatbot
        function updateChatbotBadge() {
            document.getElementById('chatbotAlertBadge').textContent = dashboardData.stats.alertesCritiques;
        }

        // ========== FONCTIONS AVEC POPUP ISO ==========

        function showPopup(title, content) {
            document.getElementById('popupTitle').textContent = title;
            document.getElementById('popupBody').innerHTML = content;
            document.getElementById('popupIso').style.display = 'flex';
        }

        function closePopup() {
            document.getElementById('popupIso').style.display = 'none';
        }

        // Alertes avec popup
        function rafraichirAlertes() {
            console.log('Rafraîchissement des alertes');

            // Animer le bouton
            var refreshBtn = document.querySelector('.alerts-refresh-btn i');
            if (refreshBtn) {
                refreshBtn.style.animation = 'spin 1s linear';
                setTimeout(function() { refreshBtn.style.animation = ''; }, 1000);
            }

            // Simuler le rafraîchissement
            setTimeout(function() {
                dashboardData.alertes.reverse();
                displayAlertes();
                updateChatbotBadge();
                showNotification('Alertes rafraîchies avec succès', 'success');
            }, 800);
        }

        function voirAlerteDetailPopup(id) {
            var alerte = dashboardData.alertes.find(function(a) { return a.id == id; });
            if (alerte) {
                var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                            '<p><strong>Nom de l\'alerte:</strong> ' + alerte.nom + '</p>' +
                            '<p><strong>Description:</strong> ' + alerte.description + '</p>' +
                            '<p><strong>Serveur concerné:</strong> ' + (alerte.serveurCible || 'N/A') + '</p>' +
                            '<p><strong>Date de détection:</strong> ' + alerte.date + '</p>' +
                            '<p><strong>Criticité:</strong> <span style="color: ' + (alerte.criticite === 'CRITICAL' ? '#d50032' : '#ffc107') + '; font-weight: bold;">' +
                            (alerte.criticite === 'CRITICAL' ? 'CRITIQUE' : 'ALERTE') + '</span></p>' +
                            '</div>';

                showPopup('Détail de l\'alerte #' + id, content);
            }
        }

        // Tests avec popup
        function lancerTousTestsPopup() {
            var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                        '<p><strong>Action:</strong> Lancer tous les tests</p>' +
                        '<p><strong>Portée:</strong> Tous les serveurs actifs</p>' +
                        '<p><strong>Nombre de serveurs:</strong> ' + dashboardData.stats.serveursActifs + '</p>' +
                        '<p><strong>Durée estimée:</strong> 2-3 minutes</p>' +
                        '<p style="color: #006747; font-weight: bold; margin-top: 15px;">Confirmez-vous le lancement de tous les tests ?</p>' +
                        '</div>';

            showPopup('Lancer tous les tests', content);

            // Ajouter un bouton de confirmation
            var popupFooter = document.querySelector('.popup-footer');
            popupFooter.innerHTML = '<button class="btn-quick-action" style="background: #6c757d;" onclick="closePopup()">Annuler</button>' +
                                  '<button class="btn-quick-action" onclick="executeLancerTousTests()">Confirmer</button>';
        }

        function executeLancerTousTests() {
            closePopup();

            // Simuler le lancement des tests
            showNotification('Tous les tests ont été lancés avec succès', 'success');

            // Simuler un délai court pour éviter la violation
            setTimeout(function() {
                console.log('Tests lancés');
            }, 100);
        }

        function dashboardLancerTestsCategoriePopup() {
            var categorieSelect = document.getElementById('categorieSelectDashboard');
            var categorie = categorieSelect.value;

            if (!categorie) {
                showPopup('Erreur de sélection', '<p style="color: #d50032; font-weight: bold;">Veuillez sélectionner une catégorie de tests.</p>');
                return;
            }

            var categorieNoms = {
                'conformite': 'Conformité',
                'processus_metier': 'Processus Métier',
                'surveillance': 'Surveillance',
                'ged': 'GED',
                'integration': 'Intégration',
                'web': 'Applications Web'
            };

            var nomCategorie = categorieNoms[categorie] || categorie;

            var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                        '<p><strong>Action:</strong> Lancer les tests par catégorie</p>' +
                        '<p><strong>Catégorie sélectionnée:</strong> ' + nomCategorie + '</p>' +
                        '<p><strong>Portée:</strong> Tous les serveurs concernés</p>' +
                        '<p><strong>Durée estimée:</strong> 1-2 minutes</p>' +
                        '<p style="color: #006747; font-weight: bold; margin-top: 15px;">Confirmez-vous le lancement des tests de la catégorie "' + nomCategorie + '" ?</p>' +
                        '</div>';

            showPopup('Tests par catégorie', content);

            // Ajouter un bouton de confirmation
            var popupFooter = document.querySelector('.popup-footer');
            popupFooter.innerHTML = '<button class="btn-quick-action" style="background: #6c757d;" onclick="closePopup()">Annuler</button>' +
                                  '<button class="btn-quick-action" onclick="executeTestsCategorie(\'' + categorie + '\', \'' + nomCategorie + '\')">Confirmer</button>';
        }

        function executeTestsCategorie(categorie, nomCategorie) {
            closePopup();

            // Simuler le lancement des tests
            showNotification('Tests de la catégorie "' + nomCategorie + '" lancés avec succès', 'success');

            // Simuler un délai court
            setTimeout(function() {
                console.log('Tests de catégorie ' + categorie + ' lancés');
            }, 100);
        }

        // ========== NOTIFICATION UNIQUE ==========

        function showNotification(message, type) {
            // Supprimer l'ancienne notification si elle existe
            if (currentNotification) {
                currentNotification.remove();
            }

            var notification = document.createElement('div');
            notification.className = 'notification ' + type;
            notification.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation') + '-circle"></i> ' + message;

            document.body.appendChild(notification);
            currentNotification = notification;

            setTimeout(function() {
                if (notification.parentNode) {
                    notification.remove();
                    currentNotification = null;
                }
            }, 3000);
        }

        // ========== GRAPHIQUES ==========

        function initCharts() {
            // Graphique CPU
            var cpuCtx = document.getElementById('cpuChart');
=======
            // Mettre à jour immédiatement
            updateCountdownDisplay();

            // Puis toutes les secondes
            countdownInterval = setInterval(updateCountdownDisplay, 1000);
        }

        function refreshDashboard() {
            console.log('🔄 Rafraîchissement du dashboard');

            // Animation du bouton
            const refreshBtn = document.querySelector('.alerts-refresh-btn');
            if (refreshBtn) {
                refreshBtn.style.animation = 'spin 1s ease-in-out';
                setTimeout(() => {
                    refreshBtn.style.animation = '';
                }, 1000);
            }

            // Redémarrer le compte à rebours
            startCountdown();

            // Mettre à jour l'affichage de la dernière MAJ
            const lastUpdateElement = document.getElementById('last-update-display');
            if (lastUpdateElement) {
                const now = new Date();
                lastUpdateElement.textContent = now.toLocaleString('fr-FR');
            }

            // Rafraîchir la page
            location.reload();
        }

        function setupRefreshButtons() {
            const refreshBtns = document.querySelectorAll('.refresh-dashboard-btn');
            refreshBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('🔄 Rafraîchissement manuel');
                    refreshDashboard();
                });
            });
        }

        function updateClock() {
            const now = new Date();
            const timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            const dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            const clockElement = document.getElementById('current-time');
            if (clockElement) {
                clockElement.innerHTML = `<strong>${timeStr}</strong> - ${dateStr}`;
            }
        }

        // ========== ALERTES ==========
        function rafraichirAlertes() {
            console.log('🔄 Rafraîchissement des alertes');

            const btn = document.querySelector('.btn-quick-action[onclick="rafraichirAlertes()"]');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Rafraîchissement...';
                btn.disabled = true;

                setTimeout(() => {
                    location.reload();
                }, 1500);
            }
        }

        function voirAlerteDetail(alerteId) {
            console.log(`👁️ Affichage du détail de l'alerte ${alerteId}`);
            window.location.href = `/alertes/detail?id=${alerteId}`;
        }

        // ========== FONCTIONS POUR LES TESTS ==========
        async function lancerTousTests() {
            console.log('🚀 Lancement de tous les tests');

            const confirmed = confirm('Voulez-vous lancer tous les tests ?');
            if (!confirmed) return;

            const btn = document.querySelector('.btn-test-all');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Lancement...';
                btn.disabled = true;

                try {
                    const response = await fetch('/tests/execute/all', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    });

                    const data = await response.json();

                    if (response.ok && data.success) {
                        alert('✅ ' + (data.message || 'Tests lancés avec succès !'));
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        alert('❌ Erreur: ' + (data.message || 'Échec du lancement des tests'));
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                    }
                } catch (error) {
                    console.error('Erreur:', error);
                    alert('❌ Erreur réseau: ' + error.message);
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            }
        }

        async function dashboardLancerTestsCategorie() {
            const categorieSelect = document.getElementById('categorieSelectDashboard');
            const categorie = categorieSelect.value;

            if (!categorie) {
                alert('⚠️ Veuillez sélectionner une catégorie');
                return;
            }

            console.log(`📁 Lancement des tests pour la catégorie: ${categorie}`);

            const confirmed = confirm(`Voulez-vous lancer les tests de la catégorie "${categorie}" ?`);
            if (!confirmed) return;

            const btn = document.querySelector('.btn-test-category');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Lancement...';
                btn.disabled = true;

                try {
                    const response = await fetch('/tests/execute/category', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify({ categorie: categorie })
                    });

                    const data = await response.json();

                    if (response.ok && data.success) {
                        alert('✅ ' + (data.message || `Tests de la catégorie ${categorie} lancés avec succès !`));
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        alert('❌ Erreur: ' + (data.message || 'Échec du lancement des tests'));
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                    }
                } catch (error) {
                    console.error('Erreur:', error);
                    alert('❌ Erreur réseau: ' + error.message);
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            }
        }

        // ========== GRAPHIQUES ==========
        function initCharts() {
            // Données pour le graphique CPU
            const cpuCtx = document.getElementById('cpuChart');
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            if (cpuCtx) {
                cpuChart = new Chart(cpuCtx.getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: ['00h', '04h', '08h', '12h', '16h', '20h'],
                        datasets: [{
                            label: 'Utilisation CPU (%)',
                            data: [35, 42, 38, 55, 48, 40],
                            borderColor: '#006747',
                            backgroundColor: 'rgba(0, 103, 71, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
<<<<<<< HEAD
                        plugins: { legend: { display: false } }
=======
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                ticks: {
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                    }
                });
            }

<<<<<<< HEAD
            // Graphique Mémoire
            var memoryCtx = document.getElementById('memoryChart');
=======
            // Données pour le graphique Mémoire
            const memoryCtx = document.getElementById('memoryChart');
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            if (memoryCtx) {
                memoryChart = new Chart(memoryCtx.getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: ['Serveur 1', 'Serveur 2', 'Serveur 3', 'Serveur 4', 'Serveur 5'],
                        datasets: [{
                            label: 'Utilisation Mémoire (%)',
                            data: [65, 72, 58, 81, 45],
<<<<<<< HEAD
                            backgroundColor: 'rgba(141, 198, 63, 0.8)'
=======
                            backgroundColor: 'rgba(141, 198, 63, 0.8)',
                            borderColor: 'rgba(141, 198, 63, 1)',
                            borderWidth: 1
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
<<<<<<< HEAD
                        plugins: { legend: { display: false } }
=======
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                ticks: {
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                    }
                });
            }
        }

<<<<<<< HEAD
        // ========== CHATBOT ==========

        function initChatbot() {
            var quickActions = document.createElement('div');
            quickActions.className = 'chatbot-quick-actions';
            quickActions.innerHTML = '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'alertes\')">📊 Alertes</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'serveurs\')">🖥️ Serveurs</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'tests\')">🧪 Tests</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'stats\')">📈 Statistiques</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'maj\')">🔄 MAJ</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'aide\')">❓ Aide</button>';
            document.getElementById('chatbotMessages').appendChild(quickActions);

            document.getElementById('chatbotInput').addEventListener('keypress', function(event) {
                if (event.key === 'Enter') {
                    sendChatbotMessage();
                }
            });
        }

        function toggleChatbot() {
            var chatbotWindow = document.getElementById('chatbotWindow');
=======
        // ========== ANIMATIONS ==========
        function animateStats() {
            // Animation des barres de progression
            const progressBars = document.querySelectorAll('.stat-card-progress-bar');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';

                setTimeout(() => {
                    bar.style.width = width;
                }, 300);
            });

            // Animation des cartes de statistiques
            const statCards = document.querySelectorAll('.stat-card-modern');
            statCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        }

        // Mettre à jour les graphiques périodiquement
        function updateCharts() {
            if (cpuChart) {
                // Simuler une mise à jour des données CPU
                const newData = cpuChart.data.datasets[0].data;
                newData.shift();
                newData.push(Math.floor(Math.random() * 60) + 20); // 20-80%
                cpuChart.update('none');
            }

            if (memoryChart) {
                // Simuler une mise à jour des données mémoire
                const newMemoryData = memoryChart.data.datasets[0].data;
                newMemoryData.forEach((_, i) => {
                    newMemoryData[i] = Math.min(100, Math.max(0, newMemoryData[i] + (Math.random() * 10 - 5)));
                });
                memoryChart.update('none');
            }
        }

        // Mettre à jour les graphiques toutes les 10 secondes
        setInterval(updateCharts, 10000);

        // ========== CHATBOT ==========
        function initChatbot() {
            console.log('🤖 Chatbot initialisé');
        }

        function toggleChatbot() {
            const chatbotWindow = document.getElementById('chatbotWindow');
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            if (chatbotWindow.style.display === 'flex') {
                chatbotWindow.style.display = 'none';
            } else {
                chatbotWindow.style.display = 'flex';
<<<<<<< HEAD
                document.getElementById('chatbotInput').focus();
=======
            }
        }

        function handleChatbotKeypress(event) {
            if (event.key === 'Enter') {
                sendChatbotMessage();
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            }
        }

        function sendChatbotMessage() {
<<<<<<< HEAD
            var input = document.getElementById('chatbotInput');
            var message = input.value.trim();

            if (!message) return;

            addChatMessage(message, 'user');
            input.value = '';

            setTimeout(function() {
                var response = getChatbotResponse(message);
=======
            const input = document.getElementById('chatbotInput');
            const message = input.value.trim();

            if (!message) return;

            // Ajouter le message de l'utilisateur
            addChatMessage(message, 'user');
            input.value = '';

            // Réponse du chatbot
            setTimeout(() => {
                const response = getChatbotResponse(message);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                addChatMessage(response, 'bot');
            }, 500);
        }

        function addChatMessage(message, sender) {
<<<<<<< HEAD
            var messagesContainer = document.getElementById('chatbotMessages');
            var messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + sender;
            messageDiv.innerHTML = '<div class="message-content">' + message + '</div>';
=======
            const messagesContainer = document.getElementById('chatbotMessages');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}`;
            messageDiv.innerHTML = `<div class="message-content">${message}</div>`;
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

<<<<<<< HEAD
        function chatbotQuickAction(action) {
            var messages = {
                'alertes': 'Combien d\'alertes critiques ?',
                'serveurs': 'État des serveurs ?',
                'tests': 'Comment lancer des tests ?',
                'stats': 'Statistiques du système',
                'maj': 'Prochaine mise à jour',
                'aide': 'Que peux-tu faire ?'
            };

            document.getElementById('chatbotInput').value = messages[action];
            sendChatbotMessage();
        }

        function getChatbotResponse(message) {
            var lowerMessage = message.toLowerCase();

            if (lowerMessage.includes('bonjour') || lowerMessage.includes('salut')) {
                return 'Bonjour ! Je suis l\'assistant GEID. Comment puis-je vous aider avec le tableau de bord ?';
            } else if (lowerMessage.includes('alerte') || lowerMessage.includes('critique')) {
                return 'Il y a actuellement <strong>' + dashboardData.stats.alertesCritiques + ' alertes critiques</strong>.';
            } else if (lowerMessage.includes('serveur') || lowerMessage.includes('actif')) {
                return 'Actuellement, <strong>' + dashboardData.stats.serveursActifs + '</strong> serveurs sont actifs.';
            } else if (lowerMessage.includes('disponibilité')) {
                return 'Disponibilité: <strong>' + dashboardData.stats.disponibilite + '</strong>';
            } else if (lowerMessage.includes('test') || lowerMessage.includes('lancer')) {
                return 'Utilisez les boutons "Lancer Tous les Tests" ou "Tests par Catégorie" dans les Actions Rapides.';
            } else if (lowerMessage.includes('mise à jour') || lowerMessage.includes('maj')) {
                var prochaineMAJ = document.getElementById('prochaineMAJ').textContent;
                return 'Prochaine MAJ: <strong>' + prochaineMAJ + '</strong>';
            } else {
                return 'Je peux vous aider avec les alertes, serveurs, tests, statistiques et mises à jour.';
=======
        function getChatbotResponse(message) {
            const lowerMessage = message.toLowerCase();

            if (lowerMessage.includes('bonjour') || lowerMessage.includes('salut') || lowerMessage.includes('hello')) {
                return 'Bonjour ! Comment puis-je vous aider avec le tableau de bord ?';
            } else if (lowerMessage.includes('alerte') || lowerMessage.includes('critique')) {
                const criticalCount = document.querySelector('.alert-count-critical') ?
                    document.querySelector('.alert-count-critical').textContent : '0';
                return `Il y a actuellement ${criticalCount} alertes critiques. Vous pouvez cliquer sur "Voir toutes les alertes" pour plus de détails.`;
            } else if (lowerMessage.includes('serveur') || lowerMessage.includes('actif')) {
                const serversActive = document.querySelector('[data-stat="serveursActifs"]') ?
                    document.querySelector('[data-stat="serveursActifs"]').textContent : '0/0';
                return `Actuellement, ${serversActive} serveurs sont actifs.`;
            } else if (lowerMessage.includes('disponibilité') || lowerMessage.includes('dispo')) {
                const disponibility = document.querySelector('[data-stat="disponibilite"]') ?
                    document.querySelector('[data-stat="disponibilite"]').textContent : '0%';
                return `Le taux de disponibilité actuel est de ${disponibility}.`;
            } else if (lowerMessage.includes('test') || lowerMessage.includes('lancer')) {
                return 'Vous pouvez lancer des tests via les boutons "Exécuter" dans la section "Actions Rapides".';
            } else if (lowerMessage.includes('mise à jour') || lowerMessage.includes('maj')) {
                const prochaineMAJElement = document.querySelector('.system-status-value.warning');
                const prochaineMAJ = prochaineMAJElement ? prochaineMAJElement.textContent : 'Non définie';
                return `La prochaine mise à jour est prévue pour ${prochaineMAJ}.`;
            } else if (lowerMessage.includes('aide') || lowerMessage.includes('help')) {
                return 'Je peux vous aider avec :<br>• Les alertes et incidents<br>• L\'état des serveurs<br>• Les tests et vérifications<br>• Les mises à jour<br>• Les statistiques générales';
            } else {
                return 'Je suis votre assistant pour le tableau de bord. Vous pouvez me demander des informations sur les alertes, serveurs, tests ou mises à jour.';
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
            }
        }

        // ========== UTILITAIRES ==========
<<<<<<< HEAD

        function refreshDashboard() {
            console.log('Rafraîchissement du dashboard');

            startCountdown();
            updateLastUpdate();

            showNotification('Dashboard rafraîchi avec succès', 'success');
        }

        // Rafraîchissement F5
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5') {
=======
        // Rafraîchissement manuel avec F5
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5' || (e.ctrlKey && e.key === 'r')) {
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
                e.preventDefault();
                refreshDashboard();
            }
        });
<<<<<<< HEAD
=======

        // Mettre à jour l'heure toutes les secondes
        setInterval(updateClock, 1000);
>>>>>>> c0284957ae9b2f6738b74b6c4e7053c2bf5ae1d3
    </script>
</body>
</html>